import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/MovieDetial/data/model/movie_detile.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IExploreDataSource {
  Future<List<MovieDetail>> getMovieDetailList();
}

class ExploreRemotDataSource extends IExploreDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<MovieDetail>> getMovieDetailList() async {
    try {
      var res = await _dio.get('collections/movieDetail/records');
      return res.data['items']
          .map<MovieDetail>((jsonObject) => MovieDetail.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
