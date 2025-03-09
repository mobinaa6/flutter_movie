import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';

abstract class MovieListState {}

class MovieListLoadingStat extends MovieListState {}

class MovieListRequestSuccessState extends MovieListState {
  Either<String, List<ItemCard>> itemCatdMovieGenre;

  MovieListRequestSuccessState(this.itemCatdMovieGenre);
}
