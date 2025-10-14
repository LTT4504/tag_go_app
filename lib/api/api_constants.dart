class ApiConstants {
  static const baseUrlDev = 'https://spkt.nineplus.com.vn:5012/api/';
  static const baseUrlProd = 'https://spkt.nineplus.com.vn:5012/api/';
}

class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String me = 'auth/me';
}