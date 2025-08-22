import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> userChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  /// Đăng nhập Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;
      final auth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  /// Đăng nhập ẩn danh
  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print('Error during Anonymous Sign-In: $e');
      return null;
    }
  }

  /// Đăng nhập bằng Email/Password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during Email/Password Sign-In: $e');
      return null;
    }
  }

  /// Đăng ký Email/Password
  Future<UserCredential?> registerWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during Email/Password Register: $e');
      return null;
    }
  }

  /// Đăng xuất
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('Error during Google Sign-Out: $e');
    }
    await _auth.signOut();
  }
}
