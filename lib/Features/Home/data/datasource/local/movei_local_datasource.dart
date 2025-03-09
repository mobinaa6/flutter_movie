import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/constants/string_constants.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:flutter_movie/util/network_util/intentnet_checker.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IMovieLocalDatasource {
  // action
  Future<Box<Movie>> getActionGenreMovie();
  Future<void> refreshDataMovieActionGenre();
  //romance
  Future<Box<Movie>> getRomanceGenreMovieList();
  Future<void> refreshDataMovieRomanceGenre();

  //horror
  Future<Box<Movie>> getHorrorGenreMovieList();
  Future<void> refreshDataHorrorGenre();

  //criminal
  Future<Box<Movie>> getCriminalGenreMovieList();
  Future<void> refreshDataCriminalGenre();
  //anime
  Future<Box<Movie>> getAnimeList();
  Future<void> refreshDataAnimList();

  //cartoon
  Future<Box<Movie>> getCartoonList();
  Future<void> refreshDataCartoonList();
}

class MovieLocalDataSource extends IMovieLocalDatasource {
  final Box<Movie> _movieActionBox = Hive.box(MOVIE_ACTION_GENRE_BOX);
  final Box<Movie> _movieRomanceBox = Hive.box(MOVIE_ROMANCE_GENRE_BOX);
  final Box<Movie> _movieHorrorBox = Hive.box(MOVIE_HORROR_GENRE_BOX);
  final Box<Movie> _movieCriminalBox = Hive.box(MOVIE_CRIMINAL_GENRE_BOX);
  final Box<Movie> _animeBox = Hive.box(MOVIE_ANIME_BOX);
  final Box<Movie> _cartoonBox = Hive.box(MOVIE_CARTOON_BOX);

  final IMovieDataSource _movieDataSource = locator.get();

  @override
  Future<Box<Movie>> getActionGenreMovie() async {
    try {
      if (_movieActionBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> movieActionGenreList =
              await _movieDataSource.getActionGenreMovieList();
          for (var i = 0; i < movieActionGenreList.length; i++) {
            await _movieActionBox.put(i, movieActionGenreList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _movieActionBox;
  }

  @override
  Future<void> refreshDataMovieActionGenre() async {
    if (_movieActionBox.isNotEmpty) {
      try {
        final List<Movie> movieActionGenreList =
            await _movieDataSource.getActionGenreMovieList();

        for (var i = 0; i < movieActionGenreList.length; i++) {
          await _movieActionBox.put(i, movieActionGenreList[i]);
        }
        try {
          await _movieActionBox.delete(movieActionGenreList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }

  @override
  Future<Box<Movie>> getRomanceGenreMovieList() async {
    try {
      if (_movieRomanceBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> movieRomanceGenreList =
              await _movieDataSource.getRomanceGenreMovieList();
          for (var i = 0; i < movieRomanceGenreList.length; i++) {
            await _movieRomanceBox.put(i, movieRomanceGenreList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _movieRomanceBox;
  }

  @override
  Future<void> refreshDataMovieRomanceGenre() async {
    if (_movieRomanceBox.isNotEmpty) {
      try {
        final List<Movie> movieRomanceGenreList =
            await _movieDataSource.getRomanceGenreMovieList();

        for (var i = 0; i < movieRomanceGenreList.length; i++) {
          await _movieRomanceBox.put(i, movieRomanceGenreList[i]);
        }
        try {
          await _movieRomanceBox.delete(movieRomanceGenreList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }

  @override
  Future<Box<Movie>> getHorrorGenreMovieList() async {
    try {
      if (_movieHorrorBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> movieHorrorGenreList =
              await _movieDataSource.getHorrorGenreMovieList();
          for (var i = 0; i < movieHorrorGenreList.length; i++) {
            await _movieHorrorBox.put(i, movieHorrorGenreList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _movieHorrorBox;
  }

  @override
  Future<void> refreshDataHorrorGenre() async {
    if (_movieHorrorBox.isNotEmpty) {
      try {
        final List<Movie> movieHorrorGenreList =
            await _movieDataSource.getHorrorGenreMovieList();

        for (var i = 0; i < movieHorrorGenreList.length; i++) {
          await _movieHorrorBox.put(i, movieHorrorGenreList[i]);
        }
        try {
          await _movieHorrorBox.delete(movieHorrorGenreList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }

  @override
  Future<Box<Movie>> getCriminalGenreMovieList() async {
    try {
      if (_movieCriminalBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> movieCriminalGenreList =
              await _movieDataSource.getCriminalGenreMovieList();
          for (var i = 0; i < movieCriminalGenreList.length; i++) {
            await _movieCriminalBox.put(i, movieCriminalGenreList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _movieCriminalBox;
  }

  @override
  Future<void> refreshDataCriminalGenre() async {
    if (_movieCriminalBox.isNotEmpty) {
      try {
        final List<Movie> movieCriminalGenreList =
            await _movieDataSource.getCriminalGenreMovieList();

        for (var i = 0; i < movieCriminalGenreList.length; i++) {
          await _movieCriminalBox.put(i, movieCriminalGenreList[i]);
        }
        try {
          await _movieCriminalBox.delete(movieCriminalGenreList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }

  @override
  Future<Box<Movie>> getAnimeList() async {
    try {
      if (_animeBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> animeList = await _movieDataSource.getAnimeList();
          for (var i = 0; i < animeList.length; i++) {
            await _animeBox.put(i, animeList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _animeBox;
  }

  @override
  Future<void> refreshDataAnimList() async {
    if (_animeBox.isNotEmpty) {
      try {
        final List<Movie> animeList = await _movieDataSource.getAnimeList();

        for (var i = 0; i < animeList.length; i++) {
          await _animeBox.put(i, animeList[i]);
        }
        try {
          await _animeBox.delete(animeList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }

  @override
  Future<Box<Movie>> getCartoonList() async {
    try {
      if (_cartoonBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> cartoonList = await _movieDataSource.getCartoonList();
          for (var i = 0; i < cartoonList.length; i++) {
            await _cartoonBox.put(i, cartoonList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _cartoonBox;
  }

  @override
  Future<void> refreshDataCartoonList() async {
    if (_cartoonBox.isNotEmpty) {
      try {
        final List<Movie> cartoonList = await _movieDataSource.getAnimeList();

        for (var i = 0; i < cartoonList.length; i++) {
          await _cartoonBox.put(i, cartoonList[i]);
        }
        try {
          await _cartoonBox.delete(cartoonList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }
}
