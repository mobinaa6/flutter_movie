import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> getCategoryTime();
  Future<List<Category>> getCategoryCountry();
  Future<List<Category>> getCategoryGenre();
}

class CategoryRemotDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategoryTime() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'category_type="k21pilcvtfliuoa"'
      };
      var resposne = await _dio.get('collections/category/records',
          queryParameters: qParams);
      List<Category> categoryTimeList = resposne.data['items']
          .map<Category>((jsonObject) => Category.fromJson(jsonObject))
          .toList();
      return categoryTimeList;
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.statusCode!, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Category>> getCategoryCountry() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'category_type="ce2o0uqq6alvvk5"'
      };
      var resposne = await _dio.get('collections/category/records',
          queryParameters: qParams);
      List<Category> categoryCountryList = resposne.data['items']
          .map<Category>((jsonObject) => Category.fromJson(jsonObject))
          .toList();
      return categoryCountryList;
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.statusCode!, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }

  @override
  Future<List<Category>> getCategoryGenre() async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'category_type="uvazjw9656bofqb"'
      };
      var resposne = await _dio.get('collections/category/records',
          queryParameters: qParams);
      List<Category> categoryGenreList = resposne.data['items']
          .map<Category>((jsonObject) => Category.fromJson(jsonObject))
          .toList();
      return categoryGenreList;
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.statusCode!, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
