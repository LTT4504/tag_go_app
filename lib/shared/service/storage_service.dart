import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _box = GetStorage();
  static const _token = 'token';
  static const _keyUserId = 'userId';
  static const _keyEmail = 'email';

  /// Lưu userId & email
  static Future<void> saveUser(String userId, String? email) async {
    await _box.write(_keyUserId, userId);
    if (email != null) {
      await _box.write(_keyEmail, email);
    }
  }

  static String? get token =>
      _box.read<String>(_token);

  /// Lấy userId
  static String? get userId => _box.read<String>(_keyUserId);

  /// Lấy email
  static String? get email => _box.read<String>(_keyEmail);

  /// Xoá dữ liệu user
  static Future<void> clearUser() async {
    await _box.remove(_keyUserId);
    await _box.remove(_keyEmail);
  }

  /// Kiểm tra đã đăng nhập chưa
  static bool get isLoggedIn => userId != null;
}
