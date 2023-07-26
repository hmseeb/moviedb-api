import 'dart:convert';

import 'package:bloc_pattern_arc/src/models/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client, Response;

class MovieAPIProvider {
  Client client = Client();
  Future<MovieModel> fetchMovies(String api) async {
    debugPrint('fetchMovies');
    final Response response = await client.get(Uri.parse(api));
    if (response.statusCode == 200) {
      return MovieModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load post');
    }
  }
}
