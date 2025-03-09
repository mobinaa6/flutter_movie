import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class IAdverismentDataSource {
  Future<List<Advertisment>> getAdvertismentList();
}

class AdvertismentRemotDataSource extends IAdverismentDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Advertisment>> getAdvertismentList() async {
    try {
      var response = await _dio.get('collections/advertisment/records');

      return response.data['items']
          .map<Advertisment>((jsonObject) => Advertisment.fromjson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, ex.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
