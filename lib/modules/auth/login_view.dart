import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.pastelYellow,
              AppColors.textWhite,
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logo_taggo.png',
                        height: 250,
                      ),
                      const SizedBox(height: 24),

                      // Username
                      _buildInputField(
                        label: "Username",
                        onChanged: (v) => controller.username.value = v,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter username" : null,
                      ),
                      const SizedBox(height: 18),

                      // Password
                      _buildInputField(
                        label: "Password",
                        obscure: !controller.showPassword.value,
                        onChanged: (v) => controller.password.value = v,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter password" : null,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: controller.showPassword.toggle,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Remember me
                      Row(
                        children: [
                          Obx(() => Checkbox(
                                value: controller.rememberMe.value,
                                activeColor: AppColors.darkPinkColor,
                                onChanged: (val) =>
                                    controller.rememberMe.value = val ?? false,
                              )),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => ElevatedButton(
                              onPressed: controller.loading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller.login();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pinkColor,
                                elevation: 3,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: controller.loading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            )),
                      ),
                      const SizedBox(height: 14),

                      // Error message
                      Obx(() => controller.error.isNotEmpty
                          ? Text(
                              controller.error.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            )
                          : const SizedBox.shrink()),
                      const SizedBox(height: 12),

                      // Forgot password
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Divider
                      const Row(
                        children: [
                          Expanded(
                            child:
                                Divider(thickness: 1, color: Colors.black26),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "or continue with",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child:
                                Divider(thickness: 1, color: Colors.black26),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Social login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            asset: 'assets/svgs/google.svg',
                            onTap: controller.loginWithGoogle,
                          ),
                          const SizedBox(width: 16),
                          _buildSocialButton(
                            asset: 'assets/svgs/facebook.svg',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Create account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                color: AppColors.pinkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
        ),
      ),
    );
  }

  /// Input Field
  Widget _buildInputField({
    required String label,
    bool obscure = false,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      obscureText: obscure,
      onChanged: onChanged,
      validator: validator,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        labelStyle: const TextStyle(
          color: AppColors.darkPinkColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.darkPinkColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.darkPinkColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  /// Social Button
  Widget _buildSocialButton({
    required String asset,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        child: SvgPicture.asset(
          asset,
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}
