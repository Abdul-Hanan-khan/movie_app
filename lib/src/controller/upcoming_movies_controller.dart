import 'package:get/get.dart';
import 'package:movie_db_app/src/model/models/upcoming_movies.dart';
import 'package:movie_db_app/src/service/api_service.dart';

class UpComingMovieController extends GetxController{
  RxBool isLoading=false.obs;
  Rx<UpComingMovie> upCommingMovies=UpComingMovie().obs;
  @override
  void onInit() async{
    // TODO: implement onInit
    isLoading.value=true;
    upCommingMovies.value=await ApiService.upcomingMovies();
    isLoading.value=false;
    super.onInit();
  }

}