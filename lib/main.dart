import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Detail App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Model Movie
class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl: 'https://picsum.photos/id/1025/600/400',
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek', 'Behind The Scenes'],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://picsum.photos/id/1033/600/400',
    overview:
    'Deadpool teams up with Wolverine for a wild and action-packed mission across the multiverse.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: ['Red Band Trailer', 'Final Trailer', 'Interview Clip'],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    posterUrl: 'https://picsum.photos/id/1040/600/400',
    overview:
    'Riley enters a new stage of life, and her emotions must work together to handle new challenges.',
    genres: ['Animation', 'Family', 'Comedy'],
    rating: 7.9,
    trailers: ['Official Trailer', 'Meet Anxiety', 'Voice Cast Clip'],
  ),
];

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                movie.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '★ ${movie.rating} • ${movie.genres.join(', ')}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Detail Screen
class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Poster banner
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                // Gradient phủ lên ảnh
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Genres
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: movie.genres.map((genre) {
                  return Chip(label: Text(genre));
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                    const Text('Favorite'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {},
                    ),
                    const Text('Rate'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                    ),
                    const Text('Share'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Trailers
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Trailers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movie.trailers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle_fill),
                  title: Text(movie.trailers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}