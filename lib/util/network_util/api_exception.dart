import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    if (code != 400) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username']['message'] ==
          'The username is invalid or already in use.') {
        message = 'نام کاربری نا معتبر است یا قبلا استفاده شده است';
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username']['message'] ==
          'Must be in a valid format.') {
        message =
            'در نام کاربری خود از کاراکتر غیر مجاز مانند(,)استفاده کرده اید';
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username']['message'] ==
          'The length must be between 3 and 150.') {
        message = 'لطفا نام کاربری طولانی تری را انتخاب کنید';
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['email']['message'] ==
          'The email is invalid or already in use.') {
        message = 'این ایمیل قبلا استفاده شده است';
      }
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['password']['message'] ==
          'The length must be between 8 and 72.') {
        message = 'لطفا رمز طولانی تری را انتخاب کنید';
      }
    }
  }
}
