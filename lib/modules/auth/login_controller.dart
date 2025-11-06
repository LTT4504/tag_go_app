import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';
import '../../shared/service/auth_service.dart';
import '../base/base_controller.dart';

class LoginController extends BaseController<AuthService> {
  LoginController(AuthService repository) : super(repository);

  final box = GetStorage();

  /// Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Observables
  final showPassword = false.obs;
  final rememberMe = false.obs;

  /// Form Key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedLogin();
  }

  void _loadSavedLogin() {
    final savedUser = box.read("savedUsername");
    final savedPass = box.read("savedPassword");
    final remember = box.read("rememberMe") ?? false;

    if (savedUser != null && savedPass != null && remember) {
      emailController.text = savedUser;
      passwordController.text = savedPass;
      rememberMe.value = true;
    }
  }

  /// Toggle hiển thị mật khẩu
  void togglePassword() => showPassword.value = !showPassword.value;

  /// Lưu trạng thái remember me
  void toggleRemember(bool? value) {
    rememberMe.value = value ?? false;
  }

  /// --- Đăng nhập bằng Email ---
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setLoading(true);
    try {
      final cred = await repository.signInWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (cred != null) {
        _saveUser(cred.user, method: 'email');
        showSuccess('Thành công', 'Đăng nhập thành công');
        Get.offAllNamed(AppRoutes.home);
      } else {
        showError('Lỗi', 'Không thể đăng nhập');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showError('Lỗi', 'Tài khoản không tồn tại');
          break;
        case 'wrong-password':
          showError('Lỗi', 'Mật khẩu không đúng');
          break;
        default:
          showError('Lỗi', e.message ?? 'Đăng nhập thất bại');
      }
    } on PlatformException catch (e) {
      showError('Lỗi hệ thống', e.message ?? 'Không rõ nguyên nhân');
    } catch (e) {
      showError('Lỗi đăng nhập', e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// --- Đăng nhập Google ---
  Future<void> loginWithGoogle() async {
    setLoading(true);
    try {
      final cred = await repository.signInWithGoogle();
      if (cred?.user != null) {
        _saveUser(cred!.user, method: 'google');
        showSuccess('Thành công', 'Đăng nhập bằng Google thành công');
        Get.offAllNamed(AppRoutes.home);
      } else {
        showError('Đăng nhập Google', 'Quá trình đăng nhập bị hủy hoặc không thành công.');
      }
    } catch (e) {
      showError('Lỗi', 'Đăng nhập Google thất bại: $e');
    } finally {
      setLoading(false);
    }
  }

  /// --- Đăng nhập ẩn danh ---
  Future<void> continueAsGuest() async {
    setLoading(true);
    try {
      final cred = await repository.signInAnonymously();
      if (cred != null) {
        _saveUser(cred.user, method: 'guest');
        showSuccess('Thành công', 'Đăng nhập ẩn danh thành công');
        Get.offAllNamed(AppRoutes.home);
      } else {
        showError('Lỗi', 'Không thể đăng nhập ẩn danh');
      }
    } catch (e) {
      showError('Lỗi', 'Đăng nhập khách thất bại: $e');
    } finally {
      setLoading(false);
    }
  }

  /// --- Lưu user ---
  void _saveUser(User? user, {required String method}) {
    if (user == null) return;

    box.write("token", user.uid);
    box.write("email", user.email);
    box.write("loginMethod", method);
    box.write("rememberMe", rememberMe.value);

    if (rememberMe.value) {
      box.write("savedUsername", emailController.text);
      box.write("savedPassword", passwordController.text);
    } else {
      box.remove("savedUsername");
      box.remove("savedPassword");
    }
  }
}
