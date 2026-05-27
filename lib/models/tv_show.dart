class TvShow {
  final int id;
  final String name;
  final String? imageUrl;
  final double? rating;
  final String? summary;
  final List<String> genres;
  final String? status;
  final String? premiered;

  const TvShow({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.summary,
    required this.genres,
    required this.status,
    required this.premiered,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'],
      name: json['name'] ?? 'Unknown title',
      imageUrl: json['image']?['medium'],
      rating: json['rating']?['average']?.toDouble(),
      summary: json['summary'],
      genres: List<String>.from(json['genres'] ?? []),
      status: json['status'],
      premiered: json['premiered'],
    );
  }
}