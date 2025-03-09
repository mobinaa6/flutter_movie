import 'package:flutter_movie/constants/string_constants.dart';

import 'package:hive/hive.dart';
part 'advertisment.g.dart';

@HiveType(typeId: 1)
class Advertisment extends HiveObject {
  @HiveField(0)
  String? urlSite;
  @HiveField(1)
  String? thumbnail;
  @HiveField(2)
  String? id;

  Advertisment(this.urlSite, this.thumbnail, this.id);

  factory Advertisment.fromjson(Map<String, dynamic> jsonObject) {
    return Advertisment(
        jsonObject['urlSite'],
        '$BASE_URL_IMAGE/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
        jsonObject['id']);
  }
}
