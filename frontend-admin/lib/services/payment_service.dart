import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentService {
  final String baseUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  PaymentService({required this.baseUrl});

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<List<Map<String, dynamic>>> getAllPayments() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/payments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        debugPrint('Error al obtener pagos: ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('Excepción en getAllPayments: $e');
      return [];
    }
  }

  Future<bool> confirmPayment(String paymentId) async {
    try {
      final token = await _getToken();
      final response = await http.patch(
        Uri.parse('$baseUrl/payments/$paymentId/confirm'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Error al confirmar pago: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Excepción en confirmPayment: $e');
      return false;
    }
  }

  Future<bool> rejectPayment(String paymentId) async {
    try {
      final token = await _getToken();
      final response = await http.patch(
        Uri.parse('$baseUrl/payments/$paymentId/reject'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Error al rechazar pago: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Excepción en rejectPayment: $e');
      return false;
    }
  }
}

