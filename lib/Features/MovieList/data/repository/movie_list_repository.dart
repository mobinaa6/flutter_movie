import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieList/bloc/get_item_card_from_category_home.dart';
import 'package:flutter_movie/Features/MovieList/data/datasource/movie_list_datasource.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
abstract class IMovieListRepository {
  Future<List<Movie>> getMovieListByCategoryGenre(String categoryID);
  Future<List<Movie>> getMovieListByCategoryCountry(String categoryID);

  Future<List<Movie>> getMovieListByCategoryTime(String categoryID);

  Future<List<Movie>> getMovieListByCategoryAnime();
  Future<List<Movie>> getMovieListByCategoryCartoon();
  Future<Either<String, List<ItemCard>>> getItemCardMovieGenre(
    String categoryID,
    List<Movie> movieList,
  );

  Future<Either<String, List<ItemCard>>> getItemCardMovie(
      List<Movie> movieList);
  Future<List<Movie>> getAnimeList();
  Future<List<Movie>> getCartoonList();

//method main for get item card movie
  Future<Either<String, List<ItemCard>>> getMovieListFromCategoryAndHome(
    MovieListClass movieListClass,
    String categoryId,
  );
}

class MovieListRepository extends IMovieListRepository {
  final IMovieListDataSource _movieListDataSource = locator.get();
  final IMovieDataSource _moviedataSource = locator.get();
  @override
  Future<List<Movie>> getMovieListByCategoryGenre(String categoryID) async {
    final response =
        await _movieListDataSource.getMovieListByCategoryGenre(categoryID);
    return response;
  }

  @override
  Future<List<Movie>> getMovieListByCategoryCountry(String categoryID) async {
    final response =
        await _movieListDataSource.getMovieListByCategoryCountry(categoryID);
    return response;
  }

  @override
  Future<List<Movie>> getMovieListByCategoryTime(String categoryID) async {
    final response =
        await _movieListDataSource.getMovieListByCategoryTime(categoryID);
    return response;
  }

  @override
  Future<List<Movie>> getMovieListByCategoryAnime() async {
    final response = await _moviedataSource.getAnimeList();
    return response;
  }

  @override
  Future<List<Movie>> getMovieListByCategoryCartoon() async {
    final response = await _moviedataSource.getCartoonList();
    return response;
  }

  @override
  Future<Either<String, List<ItemCard>>> getItemCardMovieGenre(
      String categoryID, List<Movie> movieList) async {
    try {
      final response = await _movieListDataSource.getItemCardMovieGenre(
          categoryID, movieList);
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<ItemCard>>> getItemCardMovie(
      List<Movie> movieList) async {
    try {
      final response = await _movieListDataSource.getItemCardMovie(movieList);
      return Right(response);
    } on DioException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<List<Movie>> getAnimeList() async {
    final response = await _moviedataSource.getAnimeList();
    return response;
  }

  @override
  Future<List<Movie>> getCartoonList() async {
    final response = await _moviedataSource.getCartoonList();
    return response;
  }

  @override
  Future<Either<String, List<ItemCard>>> getMovieListFromCategoryAndHome(
      MovieListClass movieListClass, String categoryId) async {
    return await movieListClass.getMovies(categoryId);
  }
}
