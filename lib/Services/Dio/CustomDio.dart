import 'package:dio/dio.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio();
  }

  CustomDio.withAuthentication() {
    _dio = Dio();
    _dio.interceptors
        .add(InterceptorsWrapper(onResponse: _onRespose, onError: _onError));
  }

  Dio get instance => _dio;

  _onError(DioError e) {
    return e;
  }

  _onRespose(Response e) {
    print('########### Response Log');
    print(e.data);
    print('########### Response Log');
  }
}
