import 'package:flutter_movie/util/enum/category_enum.dart';

abstract class MovieListEvent {}

class MovieListRequestFromCategoryEvent extends MovieListEvent {
  String categoryID;

  CategorytypeEnum categorytypeEnum;

  MovieListRequestFromCategoryEvent(this.categoryID, this.categorytypeEnum);
}

class MovieListRequestFromHomeState extends MovieListEvent {
  CategorytypeEnum categoryTypeEnum;

  MovieListRequestFromHomeState(this.categoryTypeEnum);
}
