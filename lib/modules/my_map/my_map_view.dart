import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_map_controller.dart';

class MyMapView extends GetView<MyMapController> {
  const MyMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bản đồ của tôi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('TP/HCM')),
                Chip(label: Text('Vui')),
                Chip(label: Text('Latte')),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => controller.items.isEmpty
                ? const Center(child: Text('Chưa có địa điểm'))
                : ListView.separated(
                    itemBuilder: (_, i) {
                      final s = controller.items[i];
                      return ListTile(
                        title: Text(s.name),
                        subtitle: Text('${s.favorites.join(", ")} • ${s.mood}'),
                        trailing: const Icon(Icons.chevron_right),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemCount: controller.items.length,
                  )),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Bạn đã đi 0 quán trong tháng này\nMón hay chọn nhất: Latte'),
          ),
        ],
      ),
    );
  }
}
