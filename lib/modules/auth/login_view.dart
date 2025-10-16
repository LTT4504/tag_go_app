import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/app_input.dart';
import '../register/register_binding.dart';
import '../register/register_view.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    final emailController = TextEditingController(
      text: controller.username.value,
    );
    final passwordController = TextEditingController(
      text: controller.password.value,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.textWhite, AppColors.pastelYellow],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(20 * scale),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Logo
                        Image.asset(
                          'assets/images/logo_taggo.png',
                          height: 220 * scale,
                        ),
                        SizedBox(height: 20 * scale),

                        /// Form
                        Form(
                          child: Column(
                            children: [
                              /// Username
                              AppInput(
                                controller: emailController,
                                label: "Email",
                                onChanged: (v) => controller.username.value = v,
                                validator:
                                    (v) =>
                                        v == null || v.isEmpty
                                            ? "Enter email"
                                            : null,
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: AppColors.darkPinkColor,
                                ),
                              ),
                              SizedBox(height: 16 * scale),

                              /// Password
                              Obx(
                                () => AppInput(
                                  controller: passwordController,
                                  label: "Password",
                                  obscure: !controller.showPassword.value,
                                  onChanged:
                                      (v) => controller.password.value = v,
                                  validator:
                                      (v) =>
                                          v == null || v.isEmpty
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
                                    onPressed: controller.togglePassword,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12 * scale),

                              /// Remember me
                              Obx(
                                () => Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1 * scale,
                                      child: Checkbox(
                                        value: controller.rememberMe.value,
                                        activeColor: AppColors.darkPinkColor,
                                        onChanged:
                                            (val) =>
                                                controller.rememberMe.value =
                                                    val ?? false,
                                      ),
                                    ),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15 * scale,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18 * scale),

                              /// Login button
                              Obx(
                                () => SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        controller.loading.value
                                            ? null
                                            : () => controller.login(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.pinkColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14 * scale,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          14 * scale,
                                        ),
                                      ),
                                    ),
                                    child:
                                        controller.loading.value
                                            ? SizedBox(
                                              width: 20 * scale,
                                              height: 20 * scale,
                                              child:
                                                  const CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                            )
                                            : Text(
                                              "Login",
                                              style: TextStyle(
                                                fontSize: 18 * scale,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14 * scale),

                        /// Error message
                        Obx(
                          () =>
                              controller.error.value.isNotEmpty
                                  ? Text(
                                    controller.error.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13 * scale,
                                    ),
                                  )
                                  : const SizedBox.shrink(),
                        ),
                        SizedBox(height: 12 * scale),

                        /// Forgot password
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15 * scale,
                            ),
                          ),
                        ),
                        SizedBox(height: 18 * scale),

                        /// Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0 * scale,
                              ),
                              child: Text(
                                "or continue with",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14 * scale,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * scale),

                        /// Social login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              asset: 'assets/svgs/google.svg',
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                controller.loginWithGoogle();
                              },
                              size: 48 * scale,
                            ),
                            SizedBox(width: 16 * scale),
                            _buildSocialButton(
                              asset: 'assets/svgs/facebook.svg',
                              onTap: () {},
                              size: 48 * scale,
                            ),
                          ],
                        ),
                        SizedBox(height: 30 * scale),

                        /// Create account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15 * scale,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(
                                  () => const RegisterView(),
                                  binding: RegisterBinding(),
                                );
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(
                                  color: AppColors.pinkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 * scale,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(), // 👉 giữ cho UI không bị dồn sát
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Social Button
  Widget _buildSocialButton({
    required String asset,
    required VoidCallback onTap,
    double size = 48,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: size / 2,
          backgroundColor: AppColors.textWhite,
          child: SvgPicture.asset(asset, height: size * 0.6, width: size * 0.6),
        ),
      ),
    );
  }
}
