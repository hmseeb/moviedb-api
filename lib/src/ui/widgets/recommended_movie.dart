import 'dart:math';

import 'package:bloc_pattern_arc/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: 300,
                height: 400,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400]!.withOpacity(0.1),
                  highlightColor: Colors.grey[100]!.withOpacity(0.1),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          final rand = random.nextInt(snapshot.data!.results.length);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Material(
                elevation: 10,
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${snapshot.data!.results[rand].posterPath}',
                      ),
                    ),
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
