import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';

abstract class MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailRequestSuccessState extends MovieDetailState {
  Either<String, MovieDetail> movieDetailData;
  bool isLinkLowEmpty;
  bool isLinkHdEmpty;
  bool isLinkFullHdEmpty;

  MovieDetailRequestSuccessState(
    this.movieDetailData,
    this.isLinkLowEmpty,
    this.isLinkHdEmpty,
    this.isLinkFullHdEmpty,
  );
}
