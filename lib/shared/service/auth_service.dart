import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taggo/routes/app_routes.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance; 
  final box = GetStorage();


  /// Lắng nghe thay đổi trạng thái đăng nhập
  Stream<User?> userChanges() => _auth.authStateChanges();

  /// User hiện tại
  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      final account = await _googleSignIn.authenticate();

      final googleAuth = account.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'MISSING_ID_TOKEN',
          message: 'Không lấy được idToken từ Google.',
        );
      }

      String? accessToken;
      try {
        final authClient = account.authorizationClient;
        final clientAuth = await authClient.authorizationForScopes(['email', 'profile']);
        accessToken = clientAuth?.accessToken;
      } catch (_) {
        accessToken = null;
      }

      // Tạo credential Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      // Đăng nhập Firebase
      final userCred = await _auth.signInWithCredential(credential);
      log('Đăng nhập Google thành công: ${userCred.user?.email}', name: 'AuthService');
      return userCred;
    } on FirebaseAuthException catch (e, stack) {
      log('FirebaseAuthException: ${e.code} - ${e.message}',
          name: 'AuthService', stackTrace: stack);
      rethrow;
    } catch (e, stack) {
      log('Lỗi khi đăng nhập Google: $e', name: 'AuthService', stackTrace: stack);
      rethrow;
    }
  }

  /// Đăng nhập bằng Email/Password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      log('Đăng nhập email thành công: ${userCred.user?.email}',
          name: 'AuthService');
      return userCred;
    } on FirebaseAuthException catch (e, stack) {
      log('Lỗi đăng nhập email: ${e.code}',
          name: 'AuthService', stackTrace: stack);
      rethrow;
    }
  }

  /// Đăng ký bằng Email/Password
  Future<UserCredential?> registerWithEmailPassword(
      String email, String password) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      log('Đăng ký thành công: ${userCred.user?.email}', name: 'AuthService');
      return userCred;
    } on FirebaseAuthException catch (e, stack) {
      log('Lỗi đăng ký: ${e.code}', name: 'AuthService', stackTrace: stack);
      rethrow;
    }
  }

  /// Đăng nhập ẩn danh
  Future<UserCredential?> signInAnonymously() async {
    try {
      final userCred = await _auth.signInAnonymously();
      log('Đăng nhập ẩn danh thành công', name: 'AuthService');
      return userCred;
    } on FirebaseAuthException catch (e, stack) {
      log('Lỗi đăng nhập ẩn danh: ${e.code}',
          name: 'AuthService', stackTrace: stack);
      rethrow;
    }
  }

Future<void> logout() async {
  final savedUser = box.read("savedUsername");
  final savedPass = box.read("savedPassword");
  final remember = box.read("rememberMe") ?? false;

  await _auth.signOut(); 

  // Xóa dữ liệu user
  await box.erase();

  // Giữ lại tài khoản nếu có bật "Ghi nhớ đăng nhập"
  if (remember) {
    box.write("savedUsername", savedUser);
    box.write("savedPassword", savedPass);
    box.write("rememberMe", true);
  }

  Get.offAllNamed(AppRoutes.login);
}

}
