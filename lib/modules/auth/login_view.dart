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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.textWhite, AppColors.pastelYellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20 * scale),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  /// Logo
                  Image.asset('assets/images/logo_taggo.png', height: 220 * scale),
                  SizedBox(height: 20 * scale),

                  /// Email
                  AppInput(
                    controller: controller.emailController,
                    label: "Email",
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter email" : null,
                    prefixIcon:
                        const Icon(Icons.person, color: AppColors.darkPinkColor),
                  ),
                  SizedBox(height: 16 * scale),

                  /// Password
                  Obx(() => AppInput(
                        controller: controller.passwordController,
                        label: "Password",
                        obscure: !controller.showPassword.value,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter password" : null,
                        prefixIcon:
                            const Icon(Icons.lock, color: AppColors.darkPinkColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: controller.togglePassword,
                        ),
                      )),
                  SizedBox(height: 12 * scale),

                  /// Remember me
                  Obx(() => Row(
                        children: [
                          Transform.scale(
                            scale: 1.1 * scale,
                            child: Checkbox(
                              value: controller.rememberMe.value,
                              activeColor: AppColors.darkPinkColor,
                              onChanged: controller.toggleRemember,
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                                fontSize: 15 * scale, color: Colors.black87),
                          ),
                        ],
                      )),
                  SizedBox(height: 18 * scale),

                  /// Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pinkColor,
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 18 * scale, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 14 * scale),

                  /// Forgot password
                  TextButton(
                    onPressed: () {},
                    child: Text("Forgot password?",
                        style: TextStyle(
                            color: Colors.black87, fontSize: 15 * scale)),
                  ),
                  SizedBox(height: 18 * scale),

                  /// Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.black26)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0 * scale),
                        child: Text("or continue with",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14 * scale)),
                      ),
                      const Expanded(child: Divider(color: Colors.black26)),
                    ],
                  ),
                  SizedBox(height: 20 * scale),

                  /// Social Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        asset: 'assets/svgs/google.svg',
                        onTap: controller.loginWithGoogle,
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

                  /// Create Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account?",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15 * scale)),
                      TextButton(
                        onPressed: () => Get.to(() => const RegisterView(),
                            binding: RegisterBinding()),
                        child: Text("Create",
                            style: TextStyle(
                                color: AppColors.pinkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15 * scale)),
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

  /// 🔹 Nút social có đổ bóng + viền nhẹ (Cách 1)
  Widget _buildSocialButton({
    required String asset,
    required VoidCallback onTap,
    double size = 48,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withOpacity(0.25), // viền mờ nhẹ
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: size * 0.55,
            height: size * 0.55,
          ),
        ),
      ),
    );
  }
}
