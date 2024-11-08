


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_app/controllers.dart/api_services.dart';
import 'package:netflix_app/models/movie_model.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final TMDBService _tmdbService = TMDBService();
  Timer? _debounceTimer;

  List<Movie> searchResults = [];
  List<Movie> trendingMovies = [];
  List<Movie> filteredTrendingMovies = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTrendingMovies();
  }

  Future<void> _loadTrendingMovies() async {
    try {
      final results = await _tmdbService.fetchMovies();
      setState(() {
        trendingMovies = results.map((movie) => Movie.fromJson(movie)).toList();
        filteredTrendingMovies = trendingMovies;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading trending movies';
      });
    }
  }

  void _searchTrendingMovies(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        filteredTrendingMovies = trendingMovies;
        isLoading = false;
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 900), () {
      setState(() {
        isLoading = true;
        filteredTrendingMovies = trendingMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        isLoading = false;
      });
    });
  }

  Widget _buildMovieListItem(Movie movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 100,
              height: 150,
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
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
            ),
          ),
          const SizedBox(width: 16),
          // Movie Title
          Expanded(
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) => _buildMovieListItem(movies[index]),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => _buildMovieCard(movies[index]),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Column(
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
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
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey[900],
                placeholderStyle: const TextStyle(color: Colors.grey),
                onChanged: _searchTrendingMovies,
              ),
            ),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              ),
            if (errorMessage.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredTrendingMovies.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              searchController.text.isEmpty
                                  ? 'Top Searches'
                                  : 'Search Results',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          searchController.text.isEmpty
                              ? _buildMovieList(filteredTrendingMovies)
                              : _buildMovieGrid(filteredTrendingMovies),
                        ],
                      )
                    else if (!isLoading && searchController.text.isNotEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'No results found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
