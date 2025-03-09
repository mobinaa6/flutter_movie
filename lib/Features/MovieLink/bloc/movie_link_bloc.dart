import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/Features/MovieDetial/data/repository/movie_link_repository.dart';
import 'package:flutter_movie/Features/MovieLink/bloc/movie_link_event.dart';
import 'package:flutter_movie/Features/MovieLink/bloc/moviie_link_state.dart';
import 'package:flutter_movie/util/enum/link_enum.type.dart';

class MovieLinkBloc extends Bloc<MovieLinkEvent, MovieLinkState> {
  final IMovieLinkRepository _movieLinkRepository;
  MovieLinkBloc(this._movieLinkRepository) : super(MovieLinkLoadingState()) {
    on<MovieLinkRequestEvent>((event, emit) async {
      Either<String, List<MovieLink>> movieLinkList = right([]);
      if (event.linkTypeEnum == LinkTypeEnum.LOW) {
        movieLinkList =
            await _movieLinkRepository.getMovieLinksLow(event.movieID);
      } else if (event.linkTypeEnum == LinkTypeEnum.HD) {
        movieLinkList =
            await _movieLinkRepository.getMovieLinksHd(event.movieID);
      } else if (event.linkTypeEnum == LinkTypeEnum.FULLHD) {
        movieLinkList =
            await _movieLinkRepository.getMovieLinksFullHd(event.movieID);
      }
      emit(MovieLinkRequestSuccessState(movieLinkList));
    });
  }
}
