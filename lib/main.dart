import 'package:flutter/material.dart';
import 'package:movie_db_app/src/controller/upcoming_movies_controller.dart';
import 'package:movie_db_app/src/ui/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var upcomingController=Get.put(UpComingMovieController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
