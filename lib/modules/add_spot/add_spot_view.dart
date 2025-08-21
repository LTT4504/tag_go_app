import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_spot_controller.dart';

class AddSpotView extends GetView<AddSpotController> {
  const AddSpotView({super.key});

  @override
  Widget build(BuildContext context) {
    // Có thể auto detect GPS -> lat/lng (geolocator) – để sau
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm địa điểm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Tên quán (có thể tự nhập)',
                prefixIcon: Icon(Icons.store),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.favCtrl,
              decoration: const InputDecoration(
                labelText: 'Món yêu thích (ngăn cách bằng dấu phẩy)',
                prefixIcon: Icon(Icons.local_cafe),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Ghi chú',
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Cảm xúc:'),
                const SizedBox(width: 8),
                Obx(() => DropdownButton<String>(
                  value: controller.mood.value,
                  items: const ['😍','😊','😐','🥲','🤯']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => controller.mood.value = v ?? '😍',
                )),
                const Spacer(),
                Obx(() => Row(
                  children: [
                    const Text('Riêng tư'),
                    Switch(
                      value: controller.isPrivate.value,
                      onChanged: (v) => controller.isPrivate.value = v,
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                final spot = controller.buildSpot();
                Get.back(result: spot);
              },
              icon: const Icon(Icons.save),
              label: const Text('Lưu địa điểm'),
            ),
          ],
        ),
      ),
    );
  }
}
