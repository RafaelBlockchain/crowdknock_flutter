import 'package:dio/dio.dart';
import 'env.dart';

class ApiConfig {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  static void setAuthToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static void clearAuthToken() {
    dio.options.headers.remove("Authorization");
  }
}

