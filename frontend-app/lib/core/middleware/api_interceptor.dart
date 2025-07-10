import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Puedes manejar errores comunes aquí
    if (err.response?.statusCode == 401) {
      // Token inválido → cerrar sesión
    }

    if (err.type == DioExceptionType.connectionTimeout) {
      // Mostrar mensaje de red lenta
    }

    super.onError(err, handler);
  }
}

