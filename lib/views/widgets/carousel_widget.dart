

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_app/models/movie_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final Future<List<Movie>> series;

  const CustomCarouselSlider({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      // height: size.height * 0.6, // Increase height for longer posters
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
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        data[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8, // Adjust this to control poster width
                // aspectRatio: 1,     // Keeps the posters proportional
                // enlargeStrategy: CenterPageEnlargeStrategy.width, // Enlarge posters by height

              ),
            );
          }
        },
      ),
    );
  }
}
