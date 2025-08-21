import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final name = controller.displayName;
    final email = controller.email;

    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ & Cài đặt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(radius: 36, child: Text(name.isNotEmpty ? name[0] : '?')),
          const SizedBox(height: 8),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          if (email != null) Text(email),
          const SizedBox(height: 16),
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) {},
            title: const Text('Dark mode (demo)'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Quyền riêng tư'),
            subtitle: const Text('Ai có thể xem bản đồ của tôi'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Đăng xuất', style: TextStyle(color: Colors.red)),
            onTap: controller.logout,
          ),
        ],
      ),
    );
  }
}
