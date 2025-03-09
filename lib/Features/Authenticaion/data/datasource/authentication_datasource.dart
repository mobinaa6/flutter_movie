import 'package:dio/dio.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Authenticaion/data/model/user.dart';
import 'package:flutter_movie/util/extetion_function/dio_exception.dart';
import 'package:flutter_movie/util/network_util/api_exception.dart';
import 'package:flutter_movie/util/network_util/auth_manager.dart';

abstract class IAuthDatasource {
  Future<void> register(User user);
  Future<String> login(String username, String password);
}

class AuthRemmotDatasource extends IAuthDatasource {
  final Dio _dio = locator.get();
  @override
  Future<void> register(User user) async {
    try {
      var response = await _dio.post('collections/users/records', data: {
        'name': user.username,
        'username': user.username,
        'password': user.password,
        'passwordConfirm': user.passwordConfirm,
        'email': user.email,
      });

      await login(user.username!, user.password!);
    } on DioException catch (ex) {
      throw ApiException(
        ex.getstatusCode(),
        ex.getMessage(),
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(0, 'unknow error');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        AuthManager.saveToken(response.data?['token']);
        AuthManager.saveID(response.data?['record']['id']);
      }
      return response.data?['token'];
    } on DioException catch (ex) {
      throw ApiException(
        ex.getstatusCode(),
        ex.getMessage(),
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(0, ex.toString());
    }
  }
}
