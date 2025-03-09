import 'package:bloc/bloc.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_event.dart';
import 'package:flutter_movie/Features/MovieList/bloc/movie_list_state.dart';
import 'package:flutter_movie/Features/MovieList/data/repository/movie_list_repository.dart';
import 'package:flutter_movie/util/extetion_function/category_type_enum_extention.dart';

class MovieListBLoc extends Bloc<MovieListEvent, MovieListState> {
  final IMovieListRepository _movieListRepository;

  MovieListBLoc(this._movieListRepository) : super(MovieListLoadingStat()) {
    on<MovieListRequestFromCategoryEvent>((event, emit) async {
      emit(MovieListLoadingStat());
      var itemCardList =
          await _movieListRepository.getMovieListFromCategoryAndHome(
              event.categorytypeEnum.getClass(), event.categoryID);
      emit(MovieListRequestSuccessState(itemCardList));
    });
    on<MovieListRequestFromHomeState>((event, emit) async {
      emit(MovieListLoadingStat());
      var itemCardList =
          await _movieListRepository.getMovieListFromCategoryAndHome(
              event.categoryTypeEnum.getClass(), '');
      emit(MovieListRequestSuccessState(itemCardList));
    });
  }
}
