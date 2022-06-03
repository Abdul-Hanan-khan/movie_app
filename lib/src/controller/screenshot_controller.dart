import 'package:get/get.dart';
import 'package:movie_db_app/src/model/models/screenshot_model.dart';
import 'package:movie_db_app/src/service/api_service.dart';
class ScreenShotController extends GetxController{
  RxBool isLoading=false.obs;
  Rx<ScreenShotsModel> ssModal=ScreenShotsModel().obs;

  Future<void> getScreenShots(String movieId) async {
    isLoading.value=true;
    ssModal.value= await ApiService.getMovieScreenShots(movieId: movieId);
    print(ssModal);
    isLoading.value=false;

  }



}