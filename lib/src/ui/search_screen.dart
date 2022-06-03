

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_app/src/controller/movie_details_controller.dart';
import 'package:movie_db_app/src/controller/search_controller.dart';
import 'package:movie_db_app/src/model/upcoming_movies.dart';
import 'package:movie_db_app/src/ui/movie_detail_screen.dart';


class SearchScreen extends StatelessWidget {
  TextEditingController search = TextEditingController();
  var movieDetailsController=Get.put(MovieDetailsController());
  SearchProductController controller = SearchProductController();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Get.back();
                },
                color: Colors.black,
              ),
              leadingWidth: 30,
              title: Text(
                "Search",
                style: TextStyle(color: Colors.black),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Product',
                          ),
                          onChanged: (value) {
                            if (value.length == 0){
                              controller.clearSearches();
                            }
                            else{
                              controller.loadSearchProduct(value);
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.searchedProducts.value.results == null
                    ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Icon(
                        Icons.search_outlined,
                        size: 60,
                        color: Colors.black38,
                      ),
                      Text(
                        'Looking for any Movie. search here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      //),
                      // listItem(1),
                    ],
                  ),
                )
                    : itemsGrid()
              ],
            ),
          )
      ),
    );
  }

  Widget itemsGrid() {
    return Obx(
          () => Container(
        width: double.infinity,
        child:  GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: controller
              .searchedProducts.value.results.length,
          itemBuilder: (context, index) {


            return GestureDetector(
              onTap: (){
                // print(movie.id);
                movieDetailsController.getDetails(moveId: controller
                    .searchedProducts.value.results[index].id);
                Get.to(MovieDetailScreen());
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),
                      // ),
                      elevation: 3,
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                          'https://image.tmdb.org/t/p/w200${controller.searchedProducts.value.results[index].posterPath}',
                          imageBuilder:
                              (context, imageProvider) {
                            return Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                // borderRadius:
                                //     BorderRadius.all(
                                //   Radius.circular(100),
                                // ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) =>
                              Container(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child:  CupertinoActivityIndicator(),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) =>
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/img_not_found.jpg'),
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          controller.searchedProducts.value.results[index].title.toUpperCase(),
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
                          controller.searchedProducts.value.results[index].originalLanguage
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
            );
          },
        ),
      ),
    );
  }
}