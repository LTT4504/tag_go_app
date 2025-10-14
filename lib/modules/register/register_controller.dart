import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  var email = "".obs;
  var phoneNumber = "".obs; // ✅ thêm số điện thoại
  var password = "".obs;
  var confirmPassword = "".obs;
  var loading = false.obs;
  var error = "".obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register() async {
    if (password.value != confirmPassword.value) {
      error.value = "Passwords do not match";

      Get.snackbar(
        "Error",
        error.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      return;
    }

    try {
      loading.value = true;
      error.value = "";

      await _auth.createUserWithEmailAndPassword(email: email.value.trim(), password: password.value.trim());

      Get.snackbar(
        "Success",
        "Account created successfully. Please login!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed("/login");
    } on FirebaseAuthException catch (e) {
      error.value = e.message ?? "Registration failed";

      Get.snackbar(
        "Error",
        error.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }
}
