
import 'dart:convert';
import 'package:http/http.dart' as http;

// class TMDBService {
//   final String apiKey = '3fe7e49fe7b38a9f4f146b33f6ed56d4';
//   final String baseUrl = 'https://api.themoviedb.org/3';

//   Future<dynamic> _get(String path) async {
//     final uri = Uri.parse('$baseUrl$path?api_key=$apiKey');

//     final response = await http.get(uri);

//     switch (response.statusCode) {
//       case 200:
//         return json.decode(response.body);
//       case 400:
//         throw Exception(
//             'Bad Request: The server could not understand the request due to invalid syntax.');
//       case 401:
//         throw Exception(
//             'Unauthorized: The client must authenticate itself to get the requested response.');
//       case 403:
//         throw Exception(
//             'Forbidden: The client does not have access rights to the content.');
//       case 404:
//         throw Exception(
//             'Not Found: The server can not find the requested resource.');
//       case 500:
//         throw Exception(
//             'Internal Server Error: The server has encountered a situation it doesn’t know how to handle.');
//       case 502:
//         throw Exception(
//             'Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server.');
//       case 503:
//         throw Exception(
//             'Service Unavailable: The server is not ready to handle the request.');
//       case 504:
//         throw Exception(
//             'Gateway Timeout: The server, while acting as a gateway or proxy, did not get a response in time from the upstream server.');
//       default:
//         throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   Future<List<dynamic>> fetchMovies() async {
//     final data = await _get('/movie/popular');
//     return data['results'];
//   }

//   Future<List<dynamic>> fetchUpcomingMovies() async {
//     final data = await _get('/movie/upcoming');
//     return data['results'];
//   }

//   Future<List<dynamic>> fetchNowPlayingMovies() async {
//     final data = await _get('/movie/now_playing');
//     return data['results'];
//   }

//   Future<List<dynamic>> fetchListSet() async {
//     final data = await _get('/movie/now_playing');
//     return data['results'];
//   }

//   Future<List<dynamic>> toprated() async {
//     final data = await _get('/movie/top_rated');
//     return data['results'];
//   }

//   Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
//     return await _get('/movie/$movieId');
//   }
// }


// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class TMDBService {
// //   final String apiKey = '8dba56e1c17d44e1a2da75fe9ceeef7d';
// //   final String baseUrl = 'https://api.themoviedb.org/3';

// //   Future<List<dynamic>> fetchMovies() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = json.decode(response.body);
// //       return data['results'];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }
// //   /////////////////series///////////////////////

// //   Future<List<dynamic>> seriesSet() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = json.decode(response.body);
// //       return data['results'];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }

// // //////////now playing///////////////////////////
// //   Future<List<dynamic>> nowPlaying() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = json.decode(response.body);
// //       return data['results'];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }

// // //////////movies of list ///////////////////////////
// //   Future<List<dynamic>> listSet() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = json.decode(response.body);
// //       return data['results'];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }

// //   ////////////////////fetchcomdy////////////////////////
// //   Future<List<dynamic>> fetchcomedy() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/person/popular?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = json.decode(response.body);
// //       return data['results'];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }

// //   ////////////////movies details///////////////////
// //   ///
// //   Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       return json.decode(response.body);
// //     } else {
// //       throw Exception('Failed to load movie details');
// //     }
// //   }
// // }

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
