import 'package:dio/dio.dart';

class dioClient {
  
  static String BASE_URL = "http://localhost:8000";

  static Dio simpleDio(String token) {
    var dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: Duration(seconds: 5) ,
        receiveTimeout: Duration(seconds: 3),
        headers: {'Content-Type': 'application/json; charset=UTF-8',
        'authorization':token
        },
    )
    );
     dio.interceptors.add(CustomLogInterceptor()); 
    return dio;
  }

  static Dio dioWithCookie(String cookie) {
    return Dio(BaseOptions(baseUrl: BASE_URL, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': cookie
    }));
  }
}


class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}