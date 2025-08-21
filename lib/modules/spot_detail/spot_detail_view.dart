import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'spot_detail_controller.dart';

class SpotDetailView extends GetView<SpotDetailController> {
  const SpotDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = controller.spot;
    return Scaffold(
      appBar: AppBar(title: Text(s.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Toạ độ: ${s.lat}, ${s.lng}'),
            const SizedBox(height: 8),
            Text('Cảm xúc: ${s.mood}'),
            const SizedBox(height: 8),
            Text('Món yêu thích: ${s.favorites.join(", ")}'),
            const SizedBox(height: 8),
            Text('Ghi chú: ${s.note}'),
            const Spacer(),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Chia sẻ'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Sửa'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Xoá', style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
