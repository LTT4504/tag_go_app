import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'intro_controller.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = [
      {'title': 'Đánh dấu quán bạn thích', 'icon': Icons.place},
      {'title': 'Lưu món ăn/ảnh/cảm xúc', 'icon': Icons.favorite},
      {'title': 'Xem lại & chia sẻ với bạn bè', 'icon': Icons.share},
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: slides.length,
                onPageChanged: (i) => controller.page.value = i,
                itemBuilder: (_, i) => _Slide(title: slides[i]['title'] as String, icon: slides[i]['icon'] as IconData),
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(slides.length, (i) {
                final active = controller.page.value == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(4),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? Colors.deepPurple : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            )),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  TextButton(onPressed: controller.skip, child: const Text('Bỏ qua')),
                  const Spacer(),
                  Obx(() {
                    final last = controller.page.value == slides.length - 1;
                    return ElevatedButton(
                      onPressed: last ? controller.done : controller.next,
                      child: Text(last ? 'Bắt đầu' : 'Tiếp'),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final IconData icon;
  const _Slide({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 96),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
