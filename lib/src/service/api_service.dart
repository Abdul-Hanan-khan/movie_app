import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db_app/src/model/movie_details_model.dart';
import 'package:movie_db_app/src/model/screenshot_model.dart';
import 'package:movie_db_app/src/model/upcoming_movies.dart';
import 'package:http/http.dart' as http;
class ApiService {

  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = 'api_key=c46ded3d6a66c2110ed6bc1f8ceb0e2a';

  static Future<UpComingMovie> upcomingMovies() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=c46ded3d6a66c2110ed6bc1f8ceb0e2a"),
      );
      if (response.statusCode == 200) {
        return UpComingMovie.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<SingleMovieDetails> getSingleMovieDetails({@required int movieId}) async {
    try {
      var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=c46ded3d6a66c2110ed6bc1f8ceb0e2a"),
      );
      if (response.statusCode == 200) {
        return SingleMovieDetails.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }
  static Future<UpComingMovie> searchMovie({String query}) async {
    try {
      var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=c46ded3d6a66c2110ed6bc1f8ceb0e2a&query=$query"),
      );
      if (response.statusCode == 200) {
        return UpComingMovie.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }
  static Future<ScreenShotsModel> getMovieScreenShots({@required String movieId}) async {
    try {
      var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId/images?api_key=c46ded3d6a66c2110ed6bc1f8ceb0e2a"),
      );
      if (response.statusCode == 200) {
        return ScreenShotsModel.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


}
