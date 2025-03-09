class MovieDetail {
  String id;
  String? writer;
  String? time;
  String? director;
  int? scoreImbd;
  String? countryName;
  String? description;
  int numberLike;
  String? trailerLink;

  MovieDetail(this.id, this.writer, this.time, this.director, this.scoreImbd,
      this.countryName, this.description, this.numberLike, this.trailerLink);

  factory MovieDetail.fromJson(Map<String, dynamic> jsonObject) {
    return MovieDetail(
      jsonObject['id'],
      jsonObject['writer'],
      jsonObject['Time'],
      jsonObject['Director'],
      jsonObject['score_imbd'],
      jsonObject['expand']['counrty_id']['title'],
      jsonObject['description'],
      jsonObject['numberLike'],
      jsonObject['trailerLink'] ?? '',
    );
  }
}
