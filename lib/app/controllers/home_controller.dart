import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:summer_class_app/app/data/model/movie_model.dart';
import 'package:summer_class_app/app/data/repository/movie_repository.dart';
import 'package:summer_class_app/app/routes/app_pages.dart';

class HomeController extends GetxController {

  bool? isLoading = true;
  List<MovieModel> movieList = [];
  final MovieRepository? movieRepository;
  HomeController({@required this.movieRepository}) : assert(movieRepository != null);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  List<String?> titles = [];
  List<Widget> images = [];
  List<String?> imgUrl = [];

  void onSelectedItem(int index) {
    Get.toNamed(Routes.DETAILS, arguments: {"movie_info":movieList[index], "tag": index+1});
  }

  void fetchData() {
    movieRepository?.getAll().then((value) {
      movieList = value;
      fillMovieInfo(movieList);
      isLoading = false;
      update();
    });
  }

  void fillMovieInfo(List<MovieModel> movieList) {
    int i = 1;
    for(MovieModel movie in movieList ){
      titles.add(movie.titulo);
      imgUrl.add(movie.img);
      images.add(
        Hero(
              tag: i,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  movie.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),);
      i++;


    }

  }

  void reloadData() {
    isLoading = true;
    update();
    titles = [];
    images = [];
    imgUrl = [];
    fetchData();
  }
}
