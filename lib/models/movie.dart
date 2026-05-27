class Movie {
  final int id;
  final String title;
  final int year;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}