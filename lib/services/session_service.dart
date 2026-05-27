import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String tokenKey = 'access_token';
  static const String usernameKey = 'username';

  Future<void> saveSession({
    required String token,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(usernameKey, username);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(usernameKey);
  }
}