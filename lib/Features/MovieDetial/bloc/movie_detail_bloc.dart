import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_event.dart';
import 'package:flutter_movie/Features/MovieDetial/bloc/movie_detail_state.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_detail_repository.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_link_repository.dart';
import 'package:flutter_movie/widget/toast.dart';

class MovieDetailBLoc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final IMovieDetailRepository movieDetailRepository;
  final IMovieLinkRepository _movieLinkRepository;
  MovieDetailBLoc(this.movieDetailRepository, this._movieLinkRepository)
      : super(MovieDetailLoadingState()) {
    on<MovieDetailRequestDataEvent>((event, emit) async {
      emit(MovieDetailLoadingState());
      final movieDetailData =
          await movieDetailRepository.getMovieDetail(event.movieID);
      final movieLinksLow =
          await _movieLinkRepository.getMovieLinksLow(event.movieID);
      final isEmptymovieLinkLow =
          movieLinksLow.fold((l) => showToast(l), (r) => r.isEmpty);
      // hd
      final movieLinksHd =
          await _movieLinkRepository.getMovieLinksHd(event.movieID);
      final isEmptymovieLinkHd =
          movieLinksHd.fold((l) => showToast(l), (r) => r.isEmpty);
      //full hd
      final movieLinksFullHd =
          await _movieLinkRepository.getMovieLinksFullHd(event.movieID);
      final isEmptymovieLinkFullHd =
          movieLinksFullHd.fold((l) => showToast(l), (r) => r.isEmpty);
      emit(
        MovieDetailRequestSuccessState(
          movieDetailData,
          isEmptymovieLinkLow,
          isEmptymovieLinkHd,
          isEmptymovieLinkFullHd!,
        ),
      );
    });

    on<MovieDetailChangeLikeEvent>((event, emit) async {
      await movieDetailRepository.updateNumberLike(
          event.movieDetailID, event.numberLike);
    });
  }
}
