import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/category/bloc/category_event.dart';
import 'package:flutter_movie/Features/category/bloc/category_state.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';
import 'package:flutter_movie/Features/category/data/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
    on<CategoryInitializeEvent>((event, emit) async {
      final Either<String, List<Category>> _categoryTimeList =
          await _categoryRepository.getCategoryTime();

      final Either<String, List<Category>> _categoryCountryList =
          await _categoryRepository.getCategoryCountry();

      final Either<String, List<Category>> _categoryGenreList =
          await _categoryRepository.getCategoryGenre();

      emit(CategoryRequstSuccessState(
          _categoryTimeList, _categoryCountryList, _categoryGenreList));
    });
  }
}
