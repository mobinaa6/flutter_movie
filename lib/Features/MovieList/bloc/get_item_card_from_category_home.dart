import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';
import 'package:flutter_movie/Features/MovieList/data/repository/movie_list_repository.dart';

abstract class MovieListClass {
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID);
}

class MovieListGenreType extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();
  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList =
        await _movieListRepository.getMovieListByCategoryGenre(categoryID);
    var itemCardList =
        await _movieListRepository.getItemCardMovieGenre(categoryID, movieList);
    return itemCardList;
  }
}

class MovieListCountryType extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList =
        await _movieListRepository.getMovieListByCategoryCountry(categoryID);
    var itemCardList =
        await _movieListRepository.getItemCardMovieGenre(categoryID, movieList);
    return itemCardList;
  }
}

class MovieListTimeType extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList =
        await _movieListRepository.getMovieListByCategoryTime(categoryID);
    var itemCardList =
        await _movieListRepository.getItemCardMovieGenre(categoryID, movieList);
    return itemCardList;
  }
}

class MovieListActionGenre extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository
        .getMovieListByCategoryGenre('93sr6ow5rn8oud3');
    var itemCardList = await _movieListRepository.getItemCardMovieGenre(
        '93sr6ow5rn8oud3', movieList);
    return itemCardList;
  }
}

class MovieListRomanceGenre extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();
  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository
        .getMovieListByCategoryGenre('gme8oxpl2ww172d');
    var itemCardList = await _movieListRepository.getItemCardMovieGenre(
        'gme8oxpl2ww172d', movieList);
    return itemCardList;
  }
}

class MovieListHorrorGenre extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();
  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository
        .getMovieListByCategoryGenre('2b7en9m40cxopqz');
    var itemCardList = await _movieListRepository.getItemCardMovieGenre(
        '2b7en9m40cxopqz', movieList);
    return itemCardList;
  }
}

class MovieListCriminaGenre extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository
        .getMovieListByCategoryGenre('93sr6ow5rn8oud3');
    var itemCardList = await _movieListRepository.getItemCardMovieGenre(
        '93sr6ow5rn8oud3', movieList);
    return itemCardList;
  }
}

class MovieListAnime extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository.getAnimeList();
    var itemCardList = await _movieListRepository.getItemCardMovie(movieList);
    return itemCardList;
  }
}

class MovieListCartoon extends MovieListClass {
  final IMovieListRepository _movieListRepository = locator.get();

  @override
  Future<Either<String, List<ItemCard>>> getMovies(String categoryID) async {
    var movieList = await _movieListRepository.getCartoonList();
    var itemCardList = await _movieListRepository.getItemCardMovie(movieList);
    return itemCardList;
  }
}
