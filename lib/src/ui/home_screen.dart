import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/src/controller/movie_details_controller.dart';
import 'package:movie_db_app/src/controller/screenshot_controller.dart';
import 'package:movie_db_app/src/controller/upcoming_movies_controller.dart';
import 'package:movie_db_app/src/model/upcoming_movies.dart';
import 'package:movie_db_app/src/ui/movie_detail_screen.dart';
import 'package:get/get.dart';
import 'package:movie_db_app/src/ui/search_screen.dart';

class HomeScreen extends StatelessWidget {
  UpComingMovieController ucmController = Get.find();
  var movieDetailsController = Get.put(MovieDetailsController());
  var screenShotController=Get.put(ScreenShotController());
  RxBool isSelectable = false.obs;
  List<String> selectedMovieIds = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        isSelectable.value = false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Icon(
              Icons.menu,
              color: Colors.black45,
            ),
            title: Text(
              'Movies-db'.toUpperCase(),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli',
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(SearchScreen());
                },
                icon: Icon(Icons.search),
                color: Colors.grey,
              )
            ],
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() => ucmController.isLoading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: Get.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount:
                            ucmController.upCommingMovies.value.results.length,
                        itemBuilder:
                            (BuildContext context, int index, int heroIndex) {
                          Results movie = ucmController
                              .upCommingMovies.value.results[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         MovieDetailScreen(movie: movie),
                              //   ),
                              // );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Platform
                                            .isAndroid
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/img_not_found.jpg'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 15,
                                    left: 15,
                                  ),
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'muli',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 12,
                            ),
                            // BuildWidgetCategory(),
                            Text(
                              'Up-Coming Movies this week'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontFamily: 'muli',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: ucmController
                                        .upCommingMovies.value.results.length,
                                    itemBuilder: (context, index) {
                                      Results movie = ucmController
                                          .upCommingMovies.value.results[index];

                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () async{
                                            movieDetailsController.getDetails(
                                                moveId: movie.id);
                                            if (!isSelectable.value){
                                             await  screenShotController.getScreenShots(movie.id.toString());
                                              Get.to(MovieDetailScreen());
                                            }
                                          },
                                          onLongPress: () {
                                            isSelectable.value = true;
                                          },
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                Card(
                                                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),
                                                  // ),
                                                  elevation: 3,
                                                  child: ClipRRect(
                                                    child: Stack(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                                          imageBuilder: (context,
                                                              imageProvider) {
                                                            return Container(
                                                              width: 100,
                                                              height: 120,
                                                              decoration:
                                                                  BoxDecoration(
                                                                // borderRadius:
                                                                //     BorderRadius.all(
                                                                //   Radius.circular(100),
                                                                // ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            width: 80,
                                                            height: 80,
                                                            child: Center(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/img_not_found.jpg'),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        isSelectable.value
                                                            ? Positioned(
                                                                right: 7,
                                                                top: 7,
                                                                child: !movie
                                                                        .isSelected
                                                                        .value
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          movie.isSelected.value =
                                                                              true;
                                                                          selectedMovieIds
                                                                              .add("${movie.id.toString()}");

                                                                          /// we will have all the ids of select movies, we can any operation with the help of ids
                                                                          print(
                                                                              selectedMovieIds);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.grey,
                                                                              border: Border.all(color: Colors.white),
                                                                              borderRadius: BorderRadius.circular(30)),
                                                                        ),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          movie.isSelected.value =
                                                                              false;
                                                                          int index = selectedMovieIds.indexWhere((element) =>
                                                                              element ==
                                                                              movie.id.toString());
                                                                          print(
                                                                              index);
                                                                          if (index !=
                                                                              -1) {
                                                                            selectedMovieIds.removeAt(index);
                                                                          }
                                                                          print(
                                                                              selectedMovieIds);
                                                                        },
                                                                        child:
                                                                            Positioned(
                                                                          right:
                                                                              7,
                                                                          top:
                                                                              7,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(color: Colors.red),
                                                                                borderRadius: BorderRadius.circular(30)),
                                                                            child:
                                                                                Center(
                                                                              child: Icon(Icons.done),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              )
                                                            : Text('')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      movie.title.toUpperCase(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 8,
                                                        fontFamily: 'muli',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      movie.originalLanguage
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 8,
                                                        fontFamily: 'muli',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
  }
}
