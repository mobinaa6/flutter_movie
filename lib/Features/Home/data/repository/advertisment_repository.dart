import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Home/data/datasource/local/advertisment_local_datasource.dart';
import 'package:flutter_movie/Features/Home/data/model/advertisment.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:hive/hive.dart';

abstract class IAdverismentRepository {
  Future<Either<String, Box<Advertisment>>> getAdvertismentList();

  Future<void> refreshDataAdvertisment();
}

class AdvertismentRepository extends IAdverismentRepository {
  final IAdvertismentLocalDataSource _localDataSource = locator.get();
  @override
  Future<Either<String, Box<Advertisment>>> getAdvertismentList() async {
    try {
      final response = await _localDataSource.getAdvertismentList();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message!);
    }
  }

  @override
  Future<void> refreshDataAdvertisment() async {
    try {
      await _localDataSource.refreshDataAdvertisment();
    } on ApiException catch (ex) {
      print('errro is -> ${ex.message}');
    }
  }
}
