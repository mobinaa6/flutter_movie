import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/movie_banner_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/constants/string_constants.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:flutter_movie/util/network_util/intentnet_checker.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IMovieBannerLocalDataSource {
  Future<Box<Movie>> getMovieBannerList();

  Future<void> refreshDataMovieBannerBox();
}

class MovieBannerLocalDatasource extends IMovieBannerLocalDataSource {
  final Box<Movie> _movieBannerBox = Hive.box(MOVIE_BANNER_BOX);
  final IMovieBannerDataSource _bannerDataSource = locator.get();
  @override
  Future<Box<Movie>> getMovieBannerList() async {
    try {
      if (_movieBannerBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Movie> movieBannerList =
              await _bannerDataSource.getMovieBannerList();
          for (var i = 0; i < movieBannerList.length; i++) {
            await _movieBannerBox.put(i, movieBannerList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _movieBannerBox;
  }

  @override
  Future<void> refreshDataMovieBannerBox() async {
    if (_movieBannerBox.isNotEmpty) {
      try {
        final List<Movie> movieBannerList =
            await _bannerDataSource.getMovieBannerList();

        for (var i = 0; i < movieBannerList.length; i++) {
          await _movieBannerBox.put(i, movieBannerList[i]);
        }
        try {
          await _movieBannerBox.delete(movieBannerList.length);
        } catch (e) {
          throw ApiException(0, 'unknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }
}
