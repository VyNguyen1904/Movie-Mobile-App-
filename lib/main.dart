import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/genre_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/post_list_screen.dart';
import 'screens/tv_explorer_screen.dart';
import 'screens/watchlist_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Browsing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const GenreScreen(),
        '/signup': (context) => const SignupScreen(),
        '/posts': (context) => const PostListScreen(),
        '/tv-explorer': (context) => const TvExplorerScreen(),
        '/watchlist': (context) => const WatchlistScreen(),
      },
    );
  }
}