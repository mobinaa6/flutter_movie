import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';

abstract class MovieLinkState {}

class MovieLinkLoadingState extends MovieLinkState {}

class MovieLinkRequestSuccessState extends MovieLinkState {
  Either<String, List<MovieLink>> movieLinkList;

  MovieLinkRequestSuccessState(this.movieLinkList);
}
