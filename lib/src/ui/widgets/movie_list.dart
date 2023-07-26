import 'package:bloc_pattern_arc/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/movies_api_provier.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    Key? key,
    required this.movieAPIProvider,
    required this.url,
  }) : super(key: key);

  final String url;
  final MovieAPIProvider movieAPIProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
      future: movieAPIProvider.fetchMovies(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
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
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!.withOpacity(0.1),
                          highlightColor: Colors.grey[100]!.withOpacity(0.1),
                          child: Container(
                            height: 10,
                            width: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!.withOpacity(0.1),
                          highlightColor: Colors.grey[100]!.withOpacity(0.1),
                          child: Container(
                            height: 10,
                            width: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 250, // Set an appropriate height for your movie grid
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.results.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data!.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // colorFilter: ColorFilter.mode(
                              //   Colors.black.withOpacity(0.5),
                              //   BlendMode.dstATop,
                              // ),
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        movie.title.length > 20
                            ? '${movie.title.substring(0, 15)}...'
                            : movie.title,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // display movie rating using RatingBar.builder package
                      RatingStars(
                        value: movie.voteAverage / 2.0,
                        starSize:
                            15, // Increase the star size for better visibility
                        starColor: const Color(
                            0xFFFEDD00), // Use an attractive color for the stars
                        starCount: 5,
                        valueLabelVisibility: false,
                        starSpacing:
                            4, // Slightly increase the spacing between stars
                      )
                    ],
                  ),
                );
              },
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
