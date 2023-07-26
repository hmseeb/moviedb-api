import 'dart:math';

import 'package:bloc_pattern_arc/src/models/movie_model.dart';
import 'package:flutter/material.dart';

import '../../resources/movies_api_provier.dart';

class RecommendedMovie extends StatelessWidget {
  const RecommendedMovie({
    Key? key,
    required this.movieAPIProvider,
    required this.url,
  }) : super(key: key);

  final String url;
  final MovieAPIProvider movieAPIProvider;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return FutureBuilder<MovieModel>(
      future: movieAPIProvider.fetchMovies(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          final rand = random.nextInt(snapshot.data!.results.length);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.dstATop,
                  ),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${snapshot.data!.results[rand].posterPath}',
                  ),
                ),
              ),
            ),
          );
        } else {
          // Handle other cases (optional)
          return const Center(
            child: Text('No data found'),
          );
        }
      },
    );
  }
}
