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
    final _formKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: double.infinity,
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
          child: Form(
            key: _formKey,
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

                _buildTextFormField(
                  controller: controller.nameCtrl,
                  label: 'Tên quán',
                  icon: Icons.storefront_rounded,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Vui lòng nhập tên quán'
                              : null,
                ),
                const SizedBox(height: 12),

                _buildTextFormField(
                  controller: controller.favCtrl,
                  label: 'Món yêu thích',
                  icon: Icons.local_cafe_rounded,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Vui lòng nhập món yêu thích'
                              : null,
                ),
                const SizedBox(height: 12),

                _buildTextFormField(
                  controller: controller.noteCtrl,
                  label: 'Ghi chú',
                  icon: Icons.notes_rounded,
                  maxLines: 3,
                  validator: (_) => null, // ghi chú không bắt buộc
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Biểu tượng:',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(() {
                        final items = [
                          {'icon': Icons.local_cafe_rounded, 'type': 'drink'},
                          {'icon': Icons.restaurant_rounded, 'type': 'food'},
                          {'icon': Icons.home_rounded, 'type': 'home'},
                          {
                            'icon': Icons.sports_esports_rounded,
                            'type': 'game',
                          },
                          {'icon': Icons.movie_sharp, 'type': 'movie'},
                        ];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              items.map((item) {
                                final isSelected =
                                    controller.placeType.value == item['type'];
                                return GestureDetector(
                                  onTap:
                                      () =>
                                          controller.placeType.value =
                                              item['type'] as String,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? AppColors.pinkColor.withOpacity(
                                                0.15,
                                              )
                                              : AppColors
                                                  .neutralLightQuaternary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColors.pinkColor
                                                : AppColors
                                                    .neutralLightSecondary,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      item['icon'] as IconData,
                                      color:
                                          isSelected
                                              ? AppColors.pinkColor
                                              : AppColors.textSecondary,
                                      size: 26,
                                    ),
                                  ),
                                );
                              }).toList(),
                        );
                      }),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (controller.placeType.value.isEmpty) {
                          Get.snackbar(
                            'Lỗi',
                            'Vui lòng chọn biểu tượng',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        final spot = controller.buildSpot();
                        Get.back(result: spot);
                      }
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
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.black),
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
