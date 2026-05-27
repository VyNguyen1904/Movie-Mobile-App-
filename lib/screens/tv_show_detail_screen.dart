import 'package:flutter/material.dart';
import '../models/tv_show.dart';

class TvShowDetailScreen extends StatefulWidget {
  final TvShow show;

  const TvShowDetailScreen({
    super.key,
    required this.show,
  });

  @override
  State<TvShowDetailScreen> createState() => _TvShowDetailScreenState();
}

class _TvShowDetailScreenState extends State<TvShowDetailScreen> {
  bool watchLater = false;

  String removeHtmlTags(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) {
      return 'No overview available.';
    }

    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    final show = widget.show;

    return Scaffold(
      appBar: AppBar(
        title: Text(show.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            show.imageUrl == null
                ? Container(
              width: double.infinity,
              height: 280,
              color: Colors.grey.shade300,
              child: const Icon(Icons.tv, size: 80),
            )
                : Image.network(
              show.imageUrl!,
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                show.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: show.genres.map((genre) {
                  return Chip(label: Text(genre));
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Rating: ${show.rating ?? 'N/A'} • Status: ${show.status ?? 'Unknown'} • Premiered: ${show.premiered ?? 'Unknown'}',
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                removeHtmlTags(show.summary),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  watchLater ? Icons.bookmark : Icons.bookmark_border,
                ),
                label: Text(
                  watchLater ? 'Added to Watch Later' : 'Add to Watch Later',
                ),
                onPressed: () {
                  setState(() {
                    watchLater = !watchLater;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}