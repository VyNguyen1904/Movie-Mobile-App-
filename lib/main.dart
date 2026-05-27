import 'package:flutter/material.dart';
import 'package:lab_5/screens/post_list_screen.dart';
import 'package:lab_5/screens/tv_explorer_screen.dart';
import 'package:lab_5/screens/watchlist_screen.dart';
import 'screens/genre_screen.dart';
import 'screens/signup_screen.dart';

void main() {
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
      home: const GenreScreen(),
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/posts': (context) => const PostListScreen(),
        '/tv-explorer': (context) => const TvExplorerScreen(),
        '/watchlist': (context) => const WatchlistScreen(),
      },
    );
  }
}