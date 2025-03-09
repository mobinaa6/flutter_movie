import 'package:dio/dio.dart';

extension DioExceptionExtention on DioException {
  int getstatusCode() {
    return response!.statusCode!;
  }

  String getMessage() {
    return response!.data['message'];
  }
}
