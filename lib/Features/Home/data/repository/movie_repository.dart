import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/movei_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IMovieRepository {
  //action
  Future<Either<String, Box<Movie>>> getActionGenreMovieList();
  Future<void> refreshDataActionGenreMovie();
  //romance
  Future<Either<String, Box<Movie>>> getRomanceGenreMovieList();
  Future<void> refreshDataMovieRomanceGenre();
  //horror
  Future<Either<String, Box<Movie>>> getHorroeGenreMovieList();
  Future<void> refreshDataMovieHorrorGenre();
  //criminal
  Future<Either<String, Box<Movie>>> getCriminalGenreMovieList();
  Future<void> refreshDataMovieCriminalGenre();

  //anime
  Future<Either<String, Box<Movie>>> getAnimeList();
  Future<void> refreshDataAnimeList();

  //cartoon
  Future<Either<String, Box<Movie>>> getCartoonList();
  Future<void> refreshDataCartoonList();
}

class MovieRepository extends IMovieRepository {
  final IMovieLocalDatasource _localDatasource = locator.get();
  @override

  //action
  Future<Either<String, Box<Movie>>> getActionGenreMovieList() async {
    try {
      var response = await _localDatasource.getActionGenreMovie();

      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataActionGenreMovie() async {
    try {
      await _localDatasource.refreshDataMovieActionGenre();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }

  //romance

  @override
  Future<Either<String, Box<Movie>>> getRomanceGenreMovieList() async {
    try {
      var response = await _localDatasource.getRomanceGenreMovieList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataMovieRomanceGenre() async {
    try {
      await _localDatasource.refreshDataMovieRomanceGenre();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }

//criminal
  @override
  Future<Either<String, Box<Movie>>> getCriminalGenreMovieList() async {
    try {
      var response = await _localDatasource.getCriminalGenreMovieList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataMovieCriminalGenre() async {
    try {
      await _localDatasource.refreshDataCriminalGenre();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }

  //horror

  @override
  Future<Either<String, Box<Movie>>> getHorroeGenreMovieList() async {
    try {
      var response = await _localDatasource.getHorrorGenreMovieList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataMovieHorrorGenre() async {
    try {
      await _localDatasource.refreshDataHorrorGenre();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }

  //anime

  @override
  Future<Either<String, Box<Movie>>> getAnimeList() async {
    try {
      var response = await _localDatasource.getAnimeList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataAnimeList() async {
    try {
      await _localDatasource.refreshDataAnimList();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }

  //cartoon

  @override
  Future<Either<String, Box<Movie>>> getCartoonList() async {
    try {
      var response = await _localDatasource.getCartoonList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataCartoonList() async {
    try {
      await _localDatasource.getCartoonList();
    } on ApiException catch (ex) {
      print('error is -> ${ex.message}');
    }
  }
}
