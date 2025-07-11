import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class PaymentService {
  final HttpClient _client = HttpClient();

  /// Obtiene todos los pagos registrados en el sistema
  Future<List<Map<String, dynamic>>> fetchPayments() async {
    final http.Response res = await _client.get(ApiRoutes.paymentsList);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('No se pudieron obtener los pagos');
    }
  }
}
