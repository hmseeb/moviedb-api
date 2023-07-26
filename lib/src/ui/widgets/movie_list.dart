import 'package:bloc_pattern_arc/src/models/movie_model.dart';
import 'package:flutter/material.dart';

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 150, // Set an appropriate height for your movie grid
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.results.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data!.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        ),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          // movie rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
