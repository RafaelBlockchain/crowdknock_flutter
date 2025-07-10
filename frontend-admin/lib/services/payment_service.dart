import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class PaymentService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 💰 Obtener todos los pagos registrados
  static Future<List<Map<String, dynamic>>> getPayments() async {
    final api = await _api();
    final data = await api.get('/payments');
    return List<Map<String, dynamic>>.from(data);
  }

  /// ✅ Confirmar un pago
  static Future<bool> confirmPayment(String paymentId) async {
    final api = await _api();
    try {
      await api.patch('/payments/$paymentId/confirm', {});
      return true;
    } catch (e) {
      return false;
    }
  }

  /// ❌ Rechazar un pago
  static Future<bool> rejectPayment(String paymentId) async {
    final api = await _api();
    try {
      await api.patch('/payments/$paymentId/reject', {});
      return true;
    } catch (e) {
      return false;
    }
  }
}

