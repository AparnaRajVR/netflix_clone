

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_app/models/movie_model.dart';

// class CustomCarouselSlider extends StatelessWidget {
//   final Future<List<Movie>> series;

//   const CustomCarouselSlider({super.key, required this.series});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return SizedBox(
//       width: size.width,
//       height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
//       child: FutureBuilder<List<Movie>>(
//         future: series,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data available'));
//           } else {
//             var data = snapshot.data!;
//             return CarouselSlider.builder(
//               itemCount: data.length,
//               itemBuilder: (BuildContext context, int index, int realIndex) {
//                 return GestureDetector(
//                   child: Column(
//                     children: [
//                       CachedNetworkImage(
//                          imageUrl: "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
              

//                         fit: BoxFit.cover,
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                       const SizedBox(height: 20,),
//                       Text(data[index].title , style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                  height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 reverse: false,
//                 viewportFraction: 0.6, 
//                 aspectRatio: 16 / 9,
//                 initialPage: 0,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class CustomCarouselSlider extends StatelessWidget {
  final Future<List<Movie>> series;

  const CustomCarouselSlider({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 250, // Adjust height as needed to prevent overflow
      child: FutureBuilder<List<Movie>>(
        future: series,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            var data = snapshot.data!;
            return CarouselSlider.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Column(
                  children: [
                    // Display the movie poster within a constrained height
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Display the movie title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        data[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,  // Limit to one line to prevent overflow
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 250, // Keep this consistent with the outer SizedBox
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.6,
              ),
            );
          }
        },
      ),
    );
  }
}
