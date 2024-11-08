import 'package:flutter/material.dart';
import 'package:netflix_app/models/movie_model.dart';

class MovieCardWidget extends StatelessWidget {
 
  Future<List<Movie>> series;
  
  final String headLineText;

   MovieCardWidget({super.key, required this.series, required this.headLineText,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: series,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          var data = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headLineText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding :const EdgeInsets.all(10),
                  itemCount: data!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${data[index].posterPath}",
                        ),
                      );
                  },
                ),
              ),
            ],
          );
      }
      }
    );
  }}
