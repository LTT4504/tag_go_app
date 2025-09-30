import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppInput extends StatelessWidget {
  final String label;
  final bool obscure; // ẩn/hiện mật khẩu
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon; // icon cuối (ví dụ: con mắt)
  final Widget? prefixIcon; // icon đầu (ví dụ: email, user)
  final TextEditingController? controller; // thêm controller
  final TextInputType? keyboardType; // Thêm thuộc tính keyboardType

  const AppInput({
    super.key,
    required this.label,
    this.obscure = false,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.keyboardType, // Khởi tạo keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // gắn controller
      obscureText: obscure,
      onChanged: onChanged,
      validator: validator,
      cursorColor: Colors.black,
      keyboardType: keyboardType, // Thêm keyboardType vào TextFormField
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        labelStyle: const TextStyle(
          color: AppColors.darkPinkColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        prefixIcon: prefixIcon, // icon đầu
        suffixIcon: suffixIcon, // icon cuối
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: AppColors.darkPinkColor, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: AppColors.darkPinkColor, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
