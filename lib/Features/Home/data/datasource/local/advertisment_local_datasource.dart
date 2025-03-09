import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/remot/advertisment_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:flutter_movie/util/network_util/intentnet_checker.dart';
import 'package:hive/hive.dart';

abstract class IAdvertismentLocalDataSource {
  Future<Box<Advertisment>> getAdvertismentList();

  Future<void> refreshDataAdvertisment();
}

class AdvertismentLocalDataSource extends IAdvertismentLocalDataSource {
  final Box<Advertisment> _advertBox = locator.get();
  final IAdverismentDataSource _adverismentDataSource = locator.get();
  @override
  Future<Box<Advertisment>> getAdvertismentList() async {
    try {
      if (_advertBox.values.toList().isEmpty) {
        if (await InternetChecker.checkConnection()) {
          List<Advertisment> advertismentList =
              await _adverismentDataSource.getAdvertismentList();
          for (var i = 0; i < advertismentList.length; i++) {
            await _advertBox.put(i, advertismentList[i]);
          }
        }
      }
    } on DioException catch (ex) {
      throw ApiException(ex.getstatusCode(), ex.getMessage());
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
    return _advertBox;
  }

  @override
  Future<void> refreshDataAdvertisment() async {
    if (_advertBox.isNotEmpty) {
      try {
        final List<Advertisment> advertismentList =
            await _adverismentDataSource.getAdvertismentList();

        for (var i = 0; i < advertismentList.length; i++) {
          await _advertBox.put(i, advertismentList[i]);
        }
        try {
          await _advertBox.delete(advertismentList.length);
        } catch (ex) {
          throw ApiException(0, 'unkknow error');
        }
      } on DioException catch (ex) {
        throw ApiException(ex.getstatusCode(), ex.getMessage());
      } catch (ex) {
        throw ApiException(0, ex.toString());
      }
    }
  }
}
