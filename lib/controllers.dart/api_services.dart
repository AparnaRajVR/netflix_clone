
import 'dart:convert';
import 'package:http/http.dart' as http;


class TMDBService {
  final String apiKey = '3fe7e49fe7b38a9f4f146b33f6ed56d4';
  final String baseUrl = 'https://api.themoviedb.org/3';

  // Helper function for GET requests
  Future<dynamic> _get(String path) async {
    final uri = Uri.parse('$baseUrl$path?api_key=$apiKey');
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad Request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not Found');
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception('Failed to load data');
    }
  }

  // Fetch popular movies
  Future<List<dynamic>> fetchMovies() async {
    final data = await _get('/movie/popular');
    return data['results'];
  }

 
  Future<List<dynamic>> fetchUpcomingMovies() async {
    final data = await _get('/movie/upcoming');
    return data['results'];
  }

 
  Future<List<dynamic>> fetchNowPlayingMovies() async {
    final data = await _get('/movie/now_playing');
    return data['results'];
  }

  
  Future<List<dynamic>> toprated() async {
    final data = await _get('/movie/top_rated');
    return data['results'];
  }
   
  Future<List<dynamic>> fetchMovieRecommendations(int movieId) async {
    final data = await _get('/movie/$movieId/recommendations');
    return data['results'];
  }

  // Fetch movie details by movie ID
  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    return await _get('/movie/$movieId');
  }

  // Add searchMovie function to search for movies by query
  Future<List<dynamic>> searchMovies(String query) async {
    final data = await _get('/search/movie?query=$query');
    return data['results'];
  }


  
}


