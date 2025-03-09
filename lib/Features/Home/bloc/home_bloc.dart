// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/Home/bloc/home_event.dart';
import 'package:flutter_movie/Features/Home/bloc/home_state.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/Home/data/repository/advertisment_repository.dart';
import 'package:flutter_movie/Features/Home/data/repository/movie_banner_respository.dart';
import 'package:flutter_movie/Features/Home/data/repository/movie_repository.dart';
import 'package:hive/hive.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IMovieBannerRepository _movieBannerRepository;
  final IMovieRepository _movieRepository;
  final IAdverismentRepository _adverismentRepository;
  HomeBloc(
    this._movieBannerRepository,
    this._movieRepository,
    this._adverismentRepository,
  ) : super(HomeLoadingState()) {
    on<HomeInitializeEvent>((event, emit) async {
      var res = await Future.wait([
        _movieBannerRepository.getMovieBannerList(),
        _movieRepository.getActionGenreMovieList(),
        _movieRepository.getRomanceGenreMovieList(),
        _adverismentRepository.getAdvertismentList(),
        _movieRepository.getHorroeGenreMovieList(),
        _movieRepository.getCriminalGenreMovieList(),
        _movieRepository.getAnimeList(),
        _movieRepository.getCartoonList()
      ]);
      emit(
        HomeRequestSuccessState(
          res.first as Either<String, Box<Movie>>,
          res[1] as Either<String, Box<Movie>>,
          res[2] as Either<String, Box<Movie>>,
          res[3] as Either<String, Box<Advertisment>>,
          res[4] as Either<String, Box<Movie>>,
          res[5] as Either<String, Box<Movie>>,
          res[6] as Either<String, Box<Movie>>,
          res[7] as Either<String, Box<Movie>>,
        ),
      );
    });

    on<HomeRefreshDataEvent>((event, emit) async {
      if (event.isInternet) {
        await _adverismentRepository.refreshDataAdvertisment();
        await _movieBannerRepository.refreshDataMovieBannerBox();
        await _movieRepository.refreshDataActionGenreMovie();
        await _movieRepository.refreshDataMovieRomanceGenre();
        await _movieRepository.refreshDataMovieHorrorGenre();
        await _movieRepository.refreshDataMovieHorrorGenre();
        await _movieRepository.refreshDataAnimeList();
        await _movieRepository.refreshDataCartoonList();
      }
    });
  }
}
