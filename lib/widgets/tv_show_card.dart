import 'package:flutter/material.dart';
import '../models/tv_show.dart';
import '../screens/tv_show_detail_screen.dart';

class TvShowCard extends StatelessWidget {
  final TvShow show;

  const TvShowCard({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: show.imageUrl == null
              ? Container(
            width: 70,
            height: 90,
            color: Colors.grey.shade300,
            child: const Icon(Icons.tv),
          )
              : Image.network(
            show.imageUrl!,
            width: 70,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          show.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Rating: ${show.rating ?? 'N/A'}\n${show.genres.join(', ')}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TvShowDetailScreen(show: show),
            ),
          );
        },
      ),
    );
  }
}