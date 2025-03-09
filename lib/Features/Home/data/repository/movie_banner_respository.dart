import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/movei_banner_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IMovieBannerRepository {
  Future<Either<String, Box<Movie>>> getMovieBannerList();

  Future<void> refreshDataMovieBannerBox();
}

class MovieBannerRepository extends IMovieBannerRepository {
  final IMovieBannerLocalDataSource _localDataSource = locator.get();
  @override
  Future<Either<String, Box<Movie>>> getMovieBannerList() async {
    try {
      var response = await _localDataSource.getMovieBannerList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataMovieBannerBox() async {
    try {
      await _localDataSource.refreshDataMovieBannerBox();
    } on ApiException catch (ex) {
      print('eror is -> ${ex.message}');
    }
  }
}
