
import 'package:flutter/material.dart';
import 'package:netflix_app/constants/utils.dart';
import 'package:netflix_app/controllers.dart/api_services.dart';
import 'package:netflix_app/models/movie_model.dart';
import 'package:netflix_app/views/screens/search_screen.dart';
import 'package:netflix_app/views/widgets/carousel_widget.dart';

import 'package:netflix_app/views/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDBService _tmdbService = TMDBService();
  late Future<List<Movie>> _series;
  late Future<List<Movie>> movies;
  late Future<List<Movie>>carousel;

 

  Future<List<Movie>> seriesData() async {
    final results = await _tmdbService.fetchMovies();
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }
  Future<List<Movie>> moviesData() async {
    final results = await _tmdbService.fetchUpcomingMovies();
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }
    Future<List<Movie>> carouselData() async {
    final results = await _tmdbService.toprated();
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }

  @override
  void initState() {
    super.initState();
    _series = seriesData();
    movies=moviesData();
    carousel=carouselData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgound,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>const SearchScreen()));
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              SizedBox(
              // height: MediaQuery.of(context).size.height * 0.5625,
              child: CustomCarouselSlider(
              series: carousel,
              ),
            ),
           const SizedBox(height: 20,),
            SizedBox(
              height: 220,
              child: MovieCardWidget(
                series: 
                _series,
                headLineText: "Now Playing",
              ),
             ),
              SizedBox(
              height: 220,
              child: MovieCardWidget(
                series:  movies,
                headLineText: "Upcoming Movies",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
