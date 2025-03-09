import 'package:dartz/dartz.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Authenticaion/data/datasource/authentication_datasource.dart';
import 'package:flutter_movie/Features/Authenticaion/data/model/user.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';

abstract class iAuthRepository {
  Future<Either<String, String>> register(User user);

  Future<Either<String, String>> login(String username, String password);
}

class AuthRepository extends iAuthRepository {
  final IAuthDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      var response = await _datasource.login(username, password);
      if (response.isNotEmpty) {
        return const Right('شما وارد شدید');
      } else {
        return const Left('خطایی در ورود پیش آمد');
      }
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطای لاگین');
    }
  }

  @override
  Future<Either<String, String>> register(User user) async {
    try {
      await _datasource.register(user);

      return const Right('ثبت نام شما انجام شد');
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
