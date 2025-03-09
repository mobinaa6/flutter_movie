import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/category/data/datasource/category_datasource.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategoryTime();
  Future<Either<String, List<Category>>> getCategoryCountry();
  Future<Either<String, List<Category>>> getCategoryGenre();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _categoryDataSource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategoryTime() async {
    try {
      var response = await _categoryDataSource.getCategoryTime();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Category>>> getCategoryCountry() async {
    try {
      var response = await _categoryDataSource.getCategoryCountry();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Category>>> getCategoryGenre() async {
    try {
      var response = await _categoryDataSource.getCategoryGenre();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }
}
