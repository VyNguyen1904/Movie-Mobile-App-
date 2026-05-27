import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_user.dart';

class AuthService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(jsonDecode(response.body));
    }

    throw Exception('Invalid username or password');
  }
}