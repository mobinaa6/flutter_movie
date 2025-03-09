import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Explore/data/datasource/explore_datasource.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IExploreRepository {
  Future<Either<String, List<MovieDetail>>> getMovieDetailList();
}

class ExploreRepository extends IExploreRepository {
  final IExploreDataSource dataSource = locator.get();
  @override
  Future<Either<String, List<MovieDetail>>> getMovieDetailList() async {
    try {
      var res = await dataSource.getMovieDetailList();
      return Right(res);
    } on ApiException catch (ex) {
      return Left(ex.message ?? '');
    }
  }
}
