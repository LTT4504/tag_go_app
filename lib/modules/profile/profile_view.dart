import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';
import '../../shared/constants/colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final name = controller.displayName;
    final email = controller.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 222, 116, 149),
        title: const Text(
          'Hồ sơ & Cài đặt',
          style: TextStyle(color: AppColors.textWhite),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.pastelYellow, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Avatar + tên + email
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.pinkColor,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (email != null)
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 108, 99, 99),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Dark mode switch
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (_) {},
                activeColor: AppColors.pinkColor,
                title: const Text('Dark mode (demo)',
                    style: TextStyle(color: AppColors.textPrimary)),
              ),
            ),
            const SizedBox(height: 16),

            // Quyền riêng tư
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.lock, color: AppColors.blueColor),
                title: const Text('Quyền riêng tư',
                    style: TextStyle(color: AppColors.textPrimary)),
                subtitle: const Text('Ai có thể xem bản đồ của tôi',
                    style: TextStyle(color: AppColors.textSecondary)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.textSecondary),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),

            // Logout
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.logout, color: AppColors.errorColor),
                title: const Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: controller.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
