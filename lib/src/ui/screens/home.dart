import 'package:bloc_pattern_arc/src/ui/widgets/recommended_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../resources/movies_api_provier.dart';
import '../widgets/movie_list.dart';
import '../widgets/title_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieAPIProvider movieAPIProvider = MovieAPIProvider();
  final String? apiKey = dotenv.env['apiKey'];

  // refresh function to reload the data
  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'For seeb',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 30,
              child: Image.network('https://i.imgur.com/BoN9kdC.png'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshData();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RecommendedMovie(
                    movieAPIProvider: movieAPIProvider,
                    url:
                        'https://api.themoviedb.org/3/movie/157336/recommendations?api_key=1f54bd990f1cdfb230adb312546d765d&language='),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(
                  title: 'Popular Movies',
                ),
                MovieListView(
                  movieAPIProvider: movieAPIProvider,
                  url:
                      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey',
                ),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(title: 'Trending Now'),
                MovieListView(
                    movieAPIProvider: movieAPIProvider,
                    url:
                        'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey'),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(title: 'Now Playing'),
                MovieListView(
                    movieAPIProvider: movieAPIProvider,
                    url:
                        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey'),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(title: 'Top 10 Shows in Pakistan Today'),
                MovieListView(
                    movieAPIProvider: movieAPIProvider,
                    url:
                        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&region=PK&sort_by=popularity.desc'),
                const SizedBox(
                  height: 20,
                ),
                const TitleText(title: 'Top-Rated Movies'),
                MovieListView(
                    movieAPIProvider: movieAPIProvider,
                    url:
                        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&region=PK&sort_by=popularity.desc'),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
