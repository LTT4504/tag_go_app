import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer'; // Added for using log

// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(); // Google Sign-In disabled

  /// Stream user thay đổi (login/logout)
  Stream<User?> userChanges() => _auth.authStateChanges();

  /// User hiện tại
  User? get currentUser => _auth.currentUser;

  /// Đăng nhập bằng Email/Password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        log("Lỗi: Mật khẩu không đúng.");
        throw FirebaseAuthException(
          code: e.code,
          message: "Mật khẩu không đúng. Vui lòng thử lại.",
        );
      } else if (e.code == 'user-not-found') {
        log("Lỗi: Không tìm thấy người dùng với email này.");
        throw FirebaseAuthException(
          code: e.code,
          message: "Không tìm thấy người dùng với email này.",
        );
      } else {
        rethrow;
      }
    }
  }

  /// Đăng ký bằng Email/Password
  Future<UserCredential?> registerWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Đăng nhập ẩn danh
  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Đăng nhập Google
  Future<UserCredential?> signInWithGoogle() async {
    // Google Sign-In functionality is currently disabled
    log("Google Sign-In is disabled.");
    return null;
  }

  /// Đăng xuất (Firebase + Google)
  Future<void> signOut() async {
    try {
      // Google Sign-In functionality is currently disabled
      log("Google Sign-Out is disabled.");
    } catch (e) {
      log("Error during Google Sign-Out: $e");
    }
    await _auth.signOut();
  }
}
