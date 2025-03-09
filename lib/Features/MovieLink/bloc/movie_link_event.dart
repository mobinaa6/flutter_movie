import 'package:flutter_movie/util/enum/link_enum.type.dart';

abstract class MovieLinkEvent {}

class MovieLinkRequestEvent extends MovieLinkEvent {
  String movieID;

  LinkTypeEnum linkTypeEnum;
  MovieLinkRequestEvent(this.movieID, this.linkTypeEnum);
}
