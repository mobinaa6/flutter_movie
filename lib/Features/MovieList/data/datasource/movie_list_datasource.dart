import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieListDataSource {
  Future<List<Movie>> getMovieListByCategoryGenre(String categoryID);
  Future<List<Movie>> getMovieListByCategoryCountry(String categoryID);
  Future<List<Movie>> getMovieListByCategoryTime(String categoryID);

  Future<List<Category>> getGenreCategoryMovies();
  Future<List<ItemCard>> getItemCardMovieGenre(
      String categoryID, List<Movie> movieList);
  Future<List<ItemCard>> getItemCardMovie(List<Movie> movieList);
}

class MovieListRemotDataSource extends IMovieListDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Movie>> getMovieListByCategoryGenre(String categoryID) async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'Movie_id',
        'filter': 'category_genre_id="$categoryID"'
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
  Future<List<Movie>> getMovieListByCategoryCountry(String categoryID) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'Category_country_id="$categoryID"'
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
  Future<List<Movie>> getMovieListByCategoryTime(String categoryID) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'caregory_time_id="$categoryID"'
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
  Future<List<Category>> getGenreCategoryMovies() async {
    try {
      Map<String, dynamic> qParams = {
        'expand': 'category_genre_id',
      };
      var response = await _dio.get('collections/movie_genre/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromJsonGenre(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<ItemCard>> getItemCardMovieGenre(
      String categoryID, List<Movie> movieList) async {
    List<Movie> movieList = await getMovieListByCategoryGenre(categoryID);
    List<Category> categoryList = await getGenreCategoryMovies();
    List<ItemCard> itemCardMovieList = [];
    for (var movie in movieList) {
      List<Category> categoryItemCardList = categoryList.where((element) {
        return element.MovieId == movie.id;
      }).toList();

      itemCardMovieList.add(ItemCard(categoryItemCardList, movie));
    }

    return itemCardMovieList;
  }

  @override
  Future<List<ItemCard>> getItemCardMovie(List<Movie> movieList) async {
    try {
      final categoryList = await getGenreCategoryMovies();
      List<ItemCard> itemCardMovieList = [];

      for (var movie in movieList) {
        final categoryListMovie = categoryList
            .where((element) => element.MovieId == movie.id)
            .toList();
        itemCardMovieList.add(ItemCard(categoryListMovie, movie));
      }
      return itemCardMovieList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
