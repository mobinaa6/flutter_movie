import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';

abstract class CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryRequstSuccessState extends CategoryState {
  Either<String, List<Category>> categoryTimeList;
  Either<String, List<Category>> categoryCountryList;
  Either<String, List<Category>> categoryGenreList;

  CategoryRequstSuccessState(
      this.categoryTimeList, this.categoryCountryList, this.categoryGenreList);
}
