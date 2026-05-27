import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_show.dart';

class TvShowService {
  static const String baseUrl = 'https://api.tvmaze.com';

  Future<List<TvShow>> searchShows(String query) async {
    final url = Uri.parse('$baseUrl/search/shows?q=$query');

    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        return jsonList.map((item) {
          return TvShow.fromJson(item['show']);
        }).toList();
      } else {
        throw Exception('Failed to load TV shows');
      }
    } catch (error) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}