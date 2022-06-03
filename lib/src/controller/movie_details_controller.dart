import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_db_app/src/model/models/movie_details_model.dart';
import 'package:movie_db_app/src/service/api_service.dart';
class MovieDetailsController extends GetxController{
  RxBool isLoading=false.obs;
  Rx<SingleMovieDetails> movieDetails=SingleMovieDetails().obs;

  void getDetails({@required int moveId})async{
    isLoading.value=true;
    movieDetails.value = await ApiService.getSingleMovieDetails(movieId: moveId);
    isLoading.value=false;

  }
}