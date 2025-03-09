abstract class MovieDetailEvent {}

class MovieDetailRequestDataEvent extends MovieDetailEvent {
  String movieID;
  MovieDetailRequestDataEvent(this.movieID);
}

class MovieDetailChangeLikeEvent extends MovieDetailEvent {
  String movieDetailID;
  int numberLike;

  MovieDetailChangeLikeEvent(this.movieDetailID, this.numberLike);
}
