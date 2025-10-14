import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/app_input.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
  

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = width / 375;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ AppColors.textWhite, AppColors.pastelYellow],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20 * scale).copyWith(top: 10 * scale),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Align all content to the top
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Logo
                  Image.asset(
                    'assets/images/logo_taggo.png',
                    height: 220 * scale,
                  ),
                  SizedBox(height: 20 * scale),

                  /// Form
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        /// Email
                        AppInput(
                          label: "Email",
                          onChanged: (v) => controller.email.value = v,
                          validator: (v) =>
                              v == null || v.isEmpty ? "Enter email" : null,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.darkPinkColor,
                          ),
                        ),
                        SizedBox(height: 16 * scale),

                        /// Phone Number ✅ thêm vào
                        AppInput(
                          label: "Phone Number",
                          keyboardType: TextInputType.phone,
                          onChanged: (v) => controller.phoneNumber.value = v,
                          validator: (v) => v == null || v.isEmpty
                              ? "Enter phone number"
                              : null,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: AppColors.darkPinkColor,
                          ),
                        ),
                        SizedBox(height: 16 * scale),

                        /// Password
                        Obx(() => AppInput(
                              label: "Password",
                              obscure: !controller.showPassword.value,
                              onChanged: (v) => controller.password.value = v,
                              validator: (v) => v == null || v.isEmpty
                                  ? "Enter password"
                                  : null,
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: AppColors.darkPinkColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.showPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: controller.showPassword.toggle,
                              ),
                            )),
                        SizedBox(height: 16 * scale),

                        /// Confirm password
                        Obx(() => AppInput(
                              label: "Confirm Password",
                              obscure: !controller.showConfirmPassword.value,
                              onChanged: (v) =>
                                  controller.confirmPassword.value = v,
                              validator: (v) => v == null || v.isEmpty
                                  ? "Confirm your password"
                                  : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: AppColors.darkPinkColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.showConfirmPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed:
                                    controller.showConfirmPassword.toggle,
                              ),
                            )),
                        SizedBox(height: 20 * scale),

                        /// Button loading
                        Obx(() => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.loading.value
                                    ? null
                                    : () {
                                        if (controller.formKey.currentState!.validate()) {
                                          controller.register();
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.pinkColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14 * scale),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14 * scale),
                                  ),
                                ),
                                child: controller.loading.value
                                    ? SizedBox(
                                        width: 20 * scale,
                                        height: 20 * scale,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 18 * scale,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 14 * scale),

                  /// Error message
                  Obx(() => controller.error.isNotEmpty
                      ? Text(
                          controller.error.value,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13 * scale,
                          ),
                        )
                      : const SizedBox.shrink()),
                  SizedBox(height: 20 * scale),

                  /// Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15 * scale,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.pinkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15 * scale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
