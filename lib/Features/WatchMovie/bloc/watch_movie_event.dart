import 'package:flutter_movie/util/enum/link_enum.type.dart';

abstract class WatchMovieEvent {}

class WathcMovieRequestEvent extends WatchMovieEvent {
  LinkTypeEnum linkTypeEnum;
  String movieID;

  WathcMovieRequestEvent(this.linkTypeEnum, this.movieID);
}
