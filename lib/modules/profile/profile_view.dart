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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.pastelYellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Appbar tuỳ chỉnh
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: AppColors.textPrimary,
                    ),
                    IconButton(
                      onPressed: controller.logout,
                      icon: const Icon(Icons.logout),
                      color: AppColors.errorColor,
                    ),
                  ],
                ),
              ),

              // Avatar + name + email
              CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.pinkColor,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 32,
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
                    color: AppColors.textSecondary,
                  ),
                ),
              const SizedBox(height: 24),

              // Thống kê: Active / Pending / Complete
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatBox("14", "Active", AppColors.pinkColor),
                    _buildStatBox("06", "Pending", AppColors.blueColor),
                    _buildStatBox("25", "Complete", AppColors.textSecondary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Danh sách setting
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildMenuItem(
                      icon: Icons.person,
                      title: "Username",
                      subtitle:
                          "@${name.toLowerCase().replaceAll(' ', '_')}",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications,
                      title: "Notifications",
                      subtitle: "Mute, Push, Email",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: "Settings",
                      subtitle: "Security, Privacy",
                      onTap: () {},
                    ),

                    // Dark Mode
                    _buildSwitchItem(
                      icon: Icons.dark_mode,
                      title: "Dark Mode",
                      value: controller.isDarkMode,
                      onChanged: (val) => controller.toggleTheme(),
                    ),

                    // Language
                    _buildMenuItem(
                      icon: Icons.language,
                      title: "Language",
                      subtitle: "English",
                      onTap: () {
                        // mở chọn ngôn ngữ
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ô thống kê
  Widget _buildStatBox(String value, String label, Color color) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Card dạng menu (có subtitle)
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 80,
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.pinkColor, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  // Card dạng switch (Dark Mode)
  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return SizedBox(
      height: 80,
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.pinkColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Switch(
                  value: value.value,
                  onChanged: onChanged,
                  activeColor: AppColors.pinkColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
