import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          children: [
            const Spacer(),
            const FlutterLogo(size: 96),
            const SizedBox(height: 12),
            const Text('TagGo'),
            const Spacer(),
            if (controller.error.isNotEmpty)
              Text(controller.error.value, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: controller.loading.value ? null : controller.loginWithGoogle,
              icon: const Icon(Icons.login),
              label: const Text('Đăng nhập với Google'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: controller.loading.value ? null : controller.continueAsGuest,
              child: const Text('Tiếp tục với Guest'),
            ),
            const SizedBox(height: 24),
          ],
        )),
      ),
    );
  }
}
