import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieLinkDataSource {
  Future<List<MovieLink>> getMovieLinksLow(String movieID);
  Future<List<MovieLink>> getMovieLinksHd(String movieID);
  Future<List<MovieLink>> getMovieLinksFullHd(String movieID);
}

class MovieLinkRemotDataSource extends IMovieLinkDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<MovieLink>> getMovieLinksLow(String movieID) async {
    Map<String, dynamic> qParams = {'filter': 'movie_id="$movieID"'};
    try {
      var res = await _dio.get('collections/movieLinkLow/records',
          queryParameters: qParams);
      return res.data['items']
          .map<MovieLink>((jsonObject) => MovieLink.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString() ?? 'unknow error');
    }
  }

  @override
  Future<List<MovieLink>> getMovieLinksHd(String movieID) async {
    Map<String, dynamic> qParams = {'filter': 'movie_id="$movieID"'};
    try {
      var res = await _dio.get('collections/movieLinkHd/records',
          queryParameters: qParams);
      return res.data['items']
          .map<MovieLink>((jsonObject) => MovieLink.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString() ?? 'unknow error');
    }
  }

  @override
  Future<List<MovieLink>> getMovieLinksFullHd(String movieID) async {
    try {
      Map<String, dynamic> qParams = {'filter': 'movie_id="$movieID"'};
      var res = await _dio.get('collections/movieLinkFullHd/records',
          queryParameters: qParams);
      return res.data['items']
          .map<MovieLink>((jsonObject) => MovieLink.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString() ?? 'unknow error');
    }
  }
}
