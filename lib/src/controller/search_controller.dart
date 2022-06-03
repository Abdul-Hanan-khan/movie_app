
import 'package:get/get.dart';
import 'package:movie_db_app/src/model/upcoming_movies.dart';
import 'package:movie_db_app/src/service/api_service.dart';


class SearchProductController extends GetxController{
  // RxList<SearchProduct> searchedProducts = <SearchProduct>[].obs;
  Rx<UpComingMovie> searchedProducts = UpComingMovie().obs;
  RxList<Results> searchList=<Results>[].obs;


  loadSearchProduct(String searchString) async {
    searchedProducts.value = (await ApiService.searchMovie(query: "$searchString"));
    print(searchedProducts);
    searchList.value=searchedProducts.value.results;
    print(searchList);
  }

  clearSearches(){
    searchedProducts.value=UpComingMovie();
  }

}