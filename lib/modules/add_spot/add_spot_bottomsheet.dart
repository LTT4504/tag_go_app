import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taggo/shared/constants/colors.dart';
import '../../models/spot_model.dart';
import 'add_spot_controller.dart';

class AddSpotBottomSheet extends GetView<AddSpotController> {
  const AddSpotBottomSheet({super.key});

  static Future<Spot?> show(BuildContext context) async {
    if (!Get.isRegistered<AddSpotController>()) {
      Get.put(AddSpotController());
    }

    return await showModalBottomSheet<Spot>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      builder: (_) => const AddSpotBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.lightScaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGray.withOpacity(0.25),
              blurRadius: 25,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.neutralLightPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Thêm địa điểm',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: controller.nameCtrl,
                label: 'Tên quán (có thể tự nhập)',
                icon: Icons.storefront_rounded,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: controller.favCtrl,
                label: 'Món yêu thích (ngăn cách bằng dấu phẩy)',
                icon: Icons.local_cafe_rounded,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: controller.noteCtrl,
                label: 'Ghi chú',
                icon: Icons.notes_rounded,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Text('Cảm xúc:', style: TextStyle(color: AppColors.textPrimary)),
                  const SizedBox(width: 8),
                  Obx(
                    () => DropdownButton<String>(
                      value: controller.mood.value,
                      style: const TextStyle(fontSize: 20),
                      dropdownColor: AppColors.white,
                      items: const ['😍', '😊', '😐', '🥲', '🤯']
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: const TextStyle(fontSize: 22)),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => controller.mood.value = v ?? '😍',
                      underline: const SizedBox(),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Row(
                      children: [
                        const Text('Riêng tư', style: TextStyle(color: AppColors.textPrimary)),
                        Switch.adaptive(
                          value: controller.isPrivate.value,
                          onChanged: (v) => controller.isPrivate.value = v,
                          activeColor: AppColors.pinkColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // nút lưu
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    final spot = controller.buildSpot();
                    Get.back(result: spot);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.pinkColor,
                          AppColors.darkPinkColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkPinkColor.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Lưu địa điểm',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.pinkColor),
        filled: true,
        fillColor: AppColors.neutralLightQuaternary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.pinkColor, width: 1),
        ),
      ),
    );
  }
}
