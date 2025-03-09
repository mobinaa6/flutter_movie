class MovieLink {
  String? id;
  String? link;
  String? movieId;
  int? part;

  MovieLink(this.id, this.link, this.movieId, this.part);

  factory MovieLink.fromJson(Map<String, dynamic> jsonObject) {
    return MovieLink(
      jsonObject['id'],
      jsonObject['link'] ?? '',
      jsonObject['movie_id'] ?? '',
      jsonObject['part'],
    );
  }
}
