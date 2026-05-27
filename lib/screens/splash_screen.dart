import 'package:flutter/material.dart';
import '../services/session_service.dart';
import 'login_screen.dart';
import 'genre_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SessionService sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 1));

    final token = await sessionService.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GenreScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}