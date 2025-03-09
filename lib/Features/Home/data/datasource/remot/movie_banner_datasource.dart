import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieBannerDataSource {
  Future<List<Movie>> getMovieBannerList();
}

class MoviBannerRemoteDataSource extends IMovieBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Movie>> getMovieBannerList() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'isBanner=true',
        'expand': 'Category_country_id'
      };
      var response =
          await _dio.get('collections/movie/records', queryParameters: qParams);
      return response.data['items']
          .map<Movie>((jsonObject) => Movie.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
