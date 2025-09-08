import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity, // ép full màn hình
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_taggo.png',
                width: 400,
                height: 400,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(
                color: AppColors.pinkColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
