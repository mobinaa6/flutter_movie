import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';

abstract class WatchMovieState {}

class WatchMovieLoadingState extends WatchMovieState {}

class WatchMovieRquestSuccessState extends WatchMovieState {
  Either<String, List<MovieLink>> movieLinks;

  WatchMovieRquestSuccessState(this.movieLinks);
}
