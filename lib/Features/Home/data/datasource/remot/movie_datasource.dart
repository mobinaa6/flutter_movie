import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieDataSource {
  Future<List<Movie>> getActionGenreMovieList();
  Future<List<Movie>> getRomanceGenreMovieList();
  Future<List<Movie>> getHorrorGenreMovieList();
  Future<List<Movie>> getCriminalGenreMovieList();
  Future<List<Movie>> getAnimeList();
  Future<List<Movie>> getCartoonList();
}

class MovieRemotDataSource extends IMovieDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Movie>> getActionGenreMovieList() async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'Movie_id',
        'filter': 'category_genre_id="1dfo5x2hwu7j3m0"'
      };
      var response = await _dio.get('collections/movie_genre/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJsonGenre(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Movie>> getRomanceGenreMovieList() async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'Movie_id',
        'filter': 'category_genre_id="gme8oxpl2ww172d"'
      };
      var response = await _dio.get('collections/movie_genre/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJsonGenre(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Movie>> getHorrorGenreMovieList() async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'Movie_id',
        'filter': 'category_genre_id="2b7en9m40cxopqz"'
      };
      var response = await _dio.get('collections/movie_genre/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJsonGenre(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Movie>> getCriminalGenreMovieList() async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'Movie_id',
        'filter': 'category_genre_id="93sr6ow5rn8oud3"'
      };
      var response = await _dio.get('collections/movie_genre/records',
          queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJsonGenre(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Movie>> getAnimeList() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'isAnime=true',
        'expand': 'Category_country_id'
      };
      var response =
          await _dio.get('collections/movie/records', queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Movie>> getCartoonList() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'isCartoon=true',
        'expand': 'Category_country_id'
      };
      var response =
          await _dio.get('collections/movie/records', queryParameters: qParams);

      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
