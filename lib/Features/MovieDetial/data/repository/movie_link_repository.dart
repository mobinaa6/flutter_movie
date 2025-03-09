import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/datasource/movie_link_datasource.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieLinkRepository {
  Future<Either<String, List<MovieLink>>> getMovieLinksLow(String movieID);
  Future<Either<String, List<MovieLink>>> getMovieLinksHd(String movieID);
  Future<Either<String, List<MovieLink>>> getMovieLinksFullHd(String movieID);
}

class MovieLinkRepository extends IMovieLinkRepository {
  final IMovieLinkDataSource _movieLinkDataSource = locator.get();

  @override
  Future<Either<String, List<MovieLink>>> getMovieLinksFullHd(
      String movieID) async {
    print('full hd started');
    try {
      var res = await _movieLinkDataSource.getMovieLinksFullHd(movieID);
      print('full hd finished');

      return Right(res);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<MovieLink>>> getMovieLinksHd(
      String movieID) async {
    print('hd started');
    try {
      var res = await _movieLinkDataSource.getMovieLinksHd(movieID);
      print('hd finished');

      return Right(res);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<MovieLink>>> getMovieLinksLow(
      String movieID) async {
    print('low started');
    try {
      var res = await _movieLinkDataSource.getMovieLinksLow(movieID);
      print('low finished');

      return Right(res);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }
}
