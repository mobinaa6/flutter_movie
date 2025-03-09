import 'package:flutter_movie/constants/string_constants.dart';

class Category {
  String? id;
  String? title;
  String? thumbnail;
  String? MovieId;

  Category(this.id, this.title, this.thumbnail, this.MovieId);

  factory Category.fromJson(Map<String, dynamic> jsonObject) {
    return Category(
        jsonObject['id'],
        jsonObject['title'],
        '$BASE_URL_IMAGE/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        null);
  }

  factory Category.fromJsonGenre(Map<String, dynamic> jsonObject) {
    return Category(
        jsonObject['expand']['category_genre_id']['id'],
        jsonObject['expand']['category_genre_id']['title'],
        '',
        jsonObject['Movie_id']);
  }
}
