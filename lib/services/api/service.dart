import 'package:dio/dio.dart';

abstract class APIService {
  Map<String, String> defaultHeader() => {
    'Content-Type': 'application/json',
  };

  Map<String, String> authorizationHeader(String accessToken) => {
    'Authorization': accessToken,
    'Content-Type': 'application/json',
  };

  Dio get dio {
    var _dio = Dio(BaseOptions(baseUrl: "http://43.201.77.195:8080/"));

    return _dio;
  }

  Dio get orgDio {
    var _dio = Dio(BaseOptions(baseUrl: "http://15.164.213.210:8000/"));

    return _dio;
  }
}
