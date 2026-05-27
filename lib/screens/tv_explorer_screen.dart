import 'package:flutter/material.dart';
import '../models/tv_show.dart';
import '../services/tv_show_service.dart';
import '../widgets/tv_show_card.dart';

class TvExplorerScreen extends StatefulWidget {
  const TvExplorerScreen({super.key});

  @override
  State<TvExplorerScreen> createState() => _TvExplorerScreenState();
}

class _TvExplorerScreenState extends State<TvExplorerScreen> {
  final TvShowService service = TvShowService();
  final TextEditingController searchController = TextEditingController();

  late Future<List<TvShow>> showsFuture;

  @override
  void initState() {
    super.initState();
    showsFuture = service.searchShows('popular');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchShows() {
    final query = searchController.text.trim();

    if (query.isEmpty) return;

    setState(() {
      showsFuture = service.searchShows(query);
    });
  }

  void retry() {
    setState(() {
      final query = searchController.text.trim().isEmpty
          ? 'popular'
          : searchController.text.trim();

      showsFuture = service.searchShows(query);
    });
  }

  List<TvShow> getRecommendedShows(List<TvShow> shows) {
    final recommended = shows.where((show) {
      return (show.rating ?? 0) >= 8.0;
    }).toList();

    return recommended.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie & TV Explorer'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Find something to watch tonight',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search TV show, e.g. friends, dark, office',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: searchShows,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => searchShows(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<List<TvShow>>(
                future: showsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Cannot load shows',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: retry,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final shows = snapshot.data ?? [];

                  if (shows.isEmpty) {
                    return const Center(
                      child: Text('No shows found. Try another keyword.'),
                    );
                  }

                  final recommendedShows = getRecommendedShows(shows);

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (recommendedShows.isNotEmpty) ...[
                        const Text(
                          'Top Picks for You',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...recommendedShows.map((show) {
                          return TvShowCard(show: show);
                        }),
                        const SizedBox(height: 16),
                      ],

                      const Text(
                        'All Results',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      ...shows.map((show) {
                        return TvShowCard(show: show);
                      }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}