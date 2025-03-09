import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_link_repository.dart';
import 'package:flutter_movie/Features/WatchMovie/bloc/watch_movie_event.dart';
import 'package:flutter_movie/Features/WatchMovie/bloc/watch_movie_state.dart';
import 'package:flutter_movie/util/enum/link_enum.type.dart';

class WatchMovieBloc extends Bloc<WatchMovieEvent, WatchMovieState> {
  final IMovieLinkRepository _movieLinkRepository;

  WatchMovieBloc(this._movieLinkRepository) : super(WatchMovieLoadingState()) {
    Either<String, List<MovieLink>> movieLinks = right([]);
    on<WathcMovieRequestEvent>((event, emit) async {
      if (event.linkTypeEnum == LinkTypeEnum.LOW) {
        movieLinks = await _movieLinkRepository.getMovieLinksLow(event.movieID);
      } else if (event.linkTypeEnum == LinkTypeEnum.HD) {
        movieLinks = await _movieLinkRepository.getMovieLinksHd(event.movieID);
      } else if (event.linkTypeEnum == LinkTypeEnum.FULLHD) {
        movieLinks =
            await _movieLinkRepository.getMovieLinksFullHd(event.movieID);
      }

      emit(WatchMovieRquestSuccessState(movieLinks));
    });
  }
}
