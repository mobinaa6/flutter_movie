import 'package:flutter_movie/constants/string_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'movie.g.dart';

@HiveType(typeId: 2)
class Movie {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? Category_country_id;
  @HiveField(2)
  String? caregory_time_id;
  @HiveField(3)
  String? MovieName;
  @HiveField(4)
  int? score;
  @HiveField(5)
  String? thumbnail;
  @HiveField(6)
  String? category_genre_id;

  Movie(this.id, this.Category_country_id, this.caregory_time_id,
      this.MovieName, this.score, this.thumbnail, this.category_genre_id);

  factory Movie.fromJson(Map<String, dynamic> jsonObject) {
    return Movie(
        jsonObject['id'],
        jsonObject['expand']['Category_country_id']['title'] ?? '',
        jsonObject['caregory_time_id'],
        jsonObject['MovieName'],
        jsonObject['score'],
        '$BASE_URL_IMAGE/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        null);
  }

  factory Movie.fromJsonGenre(Map<String, dynamic> jsonObject) {
    return Movie(
      jsonObject['expand']['Movie_id']['id'],
      jsonObject['expand']['Movie_id']['Category_country_id'],
      jsonObject['expand']['Movie_id']['caregory_time_id'],
      jsonObject['expand']['Movie_id']['MovieName'],
      jsonObject['expand']['Movie_id']['score'],
      '$BASE_URL_IMAGE/${jsonObject['expand']['Movie_id']['collectionId']}/${jsonObject['expand']['Movie_id']['id']}/${jsonObject['expand']['Movie_id']['thumbnail']}',
      jsonObject['category_genre_id'],
    );
  }
}
