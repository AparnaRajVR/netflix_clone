// import 'package:flutter/material.dart';
// import 'package:netflix_app/controllers.dart/api_services.dart';

// class MovieDetailsPage extends StatefulWidget {
//   final int movieId;
//   const MovieDetailsPage({super.key,required this.movieId});

//   @override
//   State<MovieDetailsPage> createState() => _MovieDetailsPageState();
// }

// class _MovieDetailsPageState extends State<MovieDetailsPage> {
//   TMDBService _tmdbService =TMDBService();

//     @override
//     void initState(){
//       MovieDetailsPage=_tmdbService.getmoviedetails(movieId);
//       super.initState();
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: moviedetails,
//         builder: (context,snapshot),
//         children: [
//           Stack(
//             child: Container(
//               height: MediaQuery.of(context).size.height*0.4,
//               decoration: BoxDecoration(
//                 image: DecorationImage(image: NetworkImage(https://image.tmdb.org/t/p/w500${movie.posterPath})
//               ),
//             )
//             child:SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   IconButton(
//                     icon: Icon(Icons.arrow_back_ios),
//                     onPressed: (){
//                       Navigator.pop(context)
//                     } )
//                 ]
//               ),
//             )
//                     ,
//         ])
//       ),
//       Column(
//         children: [
//           Text(movies.title)
//           style:const TextStyle(
//             fontsize:22,
//             FontWeight:fontweight.bold,
//           )
//           sizedbox(height:15),
//         ],
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:netflix_app/controllers.dart/api_services.dart';
import 'package:netflix_app/models/movie_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late Future<Map<String, dynamic>> _movieDetails;
  final TMDBService _tmdbService = TMDBService();

  @override
  void initState() {
    super.initState();
    _movieDetails = _tmdbService.fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            final movie = Movie.fromJson(snapshot.data!);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.error, color: Colors.white),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Release Date: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.releasedate,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Language: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.language.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Adult: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.adult ? 'Yes' : 'No',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}