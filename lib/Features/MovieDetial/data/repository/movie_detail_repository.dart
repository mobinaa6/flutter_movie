import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/datasource/movie_detail_datasource.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieDetailRepository {
  Future<Either<String, MovieDetail>> getMovieDetail(String movieID);

  Future<void> updateNumberLike(String movieDetailID, int numberLike);
}

class MovieDetailRepository extends IMovieDetailRepository {
  final IMovieDetailDataSource _movieDetaildataSource = locator.get();
  @override
  Future<Either<String, MovieDetail>> getMovieDetail(String movieID) async {
    print('movie detail started');
    try {
      var res = await _movieDetaildataSource.getMovieDetail(movieID);
      print('movie detail finish');

      return Right(res);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'محتوای متنی ندارد');
    }
  }

  @override
  Future<void> updateNumberLike(String movieDetailID, int numberLike) async {
    try {
      await _movieDetaildataSource.updateNumberLike(movieDetailID, numberLike);
    } on ApiException catch (ex) {
      print(ex.message);
    }
  }
}
