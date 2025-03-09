import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_link.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IMovieDetailDataSource {
  Future<MovieDetail> getMovieDetail(String movieID);

  Future<void> updateNumberLike(String movieDetailID, int numberLike);
}

class MovieDetailDataSource extends IMovieDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<MovieDetail> getMovieDetail(String movieID) async {
    Map<String, dynamic> qParams = {
      'filter': 'movie_id="$movieID"',
      'expand': 'counrty_id'
    };
    try {
      var res = await _dio.get('collections/movieDetail/records',
          queryParameters: qParams);

      return MovieDetail.fromJson(res.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString() ?? 'unknow error');
    }
  }

  @override
  Future<void> updateNumberLike(String movieDetailID, int numberLike) async {
    try {
      await _dio.patch('collections/movieDetail/records/$movieDetailID',
          data: {'numberLike': numberLike});
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
