import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  String selectedSort = 'A-Z';

  final List<String> genres = [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Family',
    'Crime',
    'Animation',
  ];

  final Set<String> selectedGenres = {};

  List<Movie> getVisibleMovies() {
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = movie.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    if (selectedSort == 'A-Z') {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == 'Z-A') {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (selectedSort == 'Year') {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year));
    } else if (selectedSort == 'Rating') {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return visibleMovies;
  }

  void toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  void clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleMovies = getVisibleMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Find a Movie',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movie title...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: genres.map((genre) {
                    final isSelected = selectedGenres.contains(genre);

                    return FilterChip(
                      label: Text(genre),
                      selected: isSelected,
                      onSelected: (_) {
                        toggleGenre(genre);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Selected genres: ${selectedGenres.length}'),
                  const Spacer(),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: const [
                      DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                      DropdownMenuItem(value: 'Z-A', child: Text('Z-A')),
                      DropdownMenuItem(value: 'Year', child: Text('Year')),
                      DropdownMenuItem(value: 'Rating', child: Text('Rating')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                ],
              ),
              if (searchQuery.isNotEmpty || selectedGenres.isNotEmpty)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: clearFilters,
                    child: const Text('Clear filters'),
                  ),
                ),
              const SizedBox(height: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 800;

                    if (visibleMovies.isEmpty) {
                      return const Center(
                        child: Text('No movies found'),
                      );
                    }

                    if (isWide) {
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3,
                        children: visibleMovies.map((movie) {
                          return MovieCard(movie: movie);
                        }).toList(),
                      );
                    }

                    return ListView.builder(
                      itemCount: visibleMovies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: visibleMovies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}