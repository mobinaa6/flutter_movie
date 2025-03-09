import 'package:dio/dio.dart';
import 'package:flutter_movie/constants/string_constants.dart';

class DioProvider {
  static Dio create() {
    return Dio(BaseOptions(baseUrl: BASE_URL));
  }
}
