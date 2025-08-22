import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppInput extends StatelessWidget {
  final String label;
  final bool obscure;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const AppInput({
    super.key,
    required this.label,
    this.obscure = false,
    required this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      onChanged: onChanged,
      validator: validator,
      cursorColor: Colors.black,
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
        suffixIcon: suffixIcon,
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
