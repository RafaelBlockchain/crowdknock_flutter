import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_app/features/payments/models/payment_model.dart';

class PaymentsService {
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  Future<List<Payment>> getAllPayments() async {
    final response = await http.get(Uri.parse('$_baseUrl/payments'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Payment.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los pagos');
    }
  }
}
