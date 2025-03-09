import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, Box<Movie>> movieBannerList;
  Either<String, Box<Movie>> actionGenreMovieList;
  Either<String, Box<Movie>> romanceGenreMovieList;
  Either<String, Box<Advertisment>> advertismentList;
  Either<String, Box<Movie>> horrorGenreMovieList;
  Either<String, Box<Movie>> criminalGenreMovieList;
  Either<String, Box<Movie>> animelIst;
  Either<String, Box<Movie>> cartoonList;

  HomeRequestSuccessState(
    this.movieBannerList,
    this.actionGenreMovieList,
    this.romanceGenreMovieList,
    this.advertismentList,
    this.horrorGenreMovieList,
    this.criminalGenreMovieList,
    this.animelIst,
    this.cartoonList,
  );
}
