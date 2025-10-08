import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import 'intro_controller.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = [
      {'title': 'Đánh dấu quán bạn thích', 'icon': Icons.place},
      {'title': 'Lưu món ăn, ảnh, cảm xúc', 'icon': Icons.favorite},
      {'title': 'Xem lại & chia sẻ với bạn bè', 'icon': Icons.share},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ AppColors.textWhite,AppColors.pastelYellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              

              // --- PageView ---
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: slides.length,
                  onPageChanged: (i) => controller.page.value = i,
                  itemBuilder: (_, i) => _Slide(
                    title: slides[i]['title'] as String,
                    icon: slides[i]['icon'] as IconData,
                  ),
                ),
              ),

              // --- Indicator ---
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(slides.length, (i) {
                      final active = controller.page.value == i;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                        width: active ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active ? AppColors.pinkColor : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  )),

              // --- Buttons ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: controller.skip,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.pinkColor,
                      ),
                      child: const Text(
                        'Bỏ qua',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Obx(() {
                      final last = controller.page.value == slides.length - 1;
                      return ElevatedButton(
                        onPressed: last ? controller.done : controller.next,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: AppColors.darkPinkColor,
                          foregroundColor: AppColors.textWhite,
                          elevation: 3,
                        ),
                        child: Text(
                          last ? 'Bắt đầu' : 'Tiếp',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Column(
        key: ValueKey(title),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.pinkColor, AppColors.pinkAppbarColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(icon, size: 96, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
