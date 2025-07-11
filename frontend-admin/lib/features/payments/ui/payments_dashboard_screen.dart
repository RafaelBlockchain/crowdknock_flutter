import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/payment_service.dart';

class PaymentsDashboardScreen extends StatefulWidget {
  const PaymentsDashboardScreen({super.key});

  @override
  State<PaymentsDashboardScreen> createState() => _PaymentsDashboardScreenState();
}

class _PaymentsDashboardScreenState extends State<PaymentsDashboardScreen> {
  final PaymentService _paymentService = PaymentService();

  List<Map<String, dynamic>> _payments = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _paymentService.fetchPayments();
      setState(() => _payments = data);
    } catch (e) {
      setState(() => _error = 'Error al cargar los pagos.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Dashboard de Pagos',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _payments.isEmpty
                  ? const Center(child: Text('No hay pagos registrados.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Usuario')),
                          DataColumn(label: Text('Monto')),
                          DataColumn(label: Text('Método')),
                          DataColumn(label: Text('Estado')),
                          DataColumn(label: Text('Fecha')),
                        ],
                        rows: _payments.map((p) {
                          return DataRow(cells: [
                            DataCell(Text(p['id'].toString())),
                            DataCell(Text(p['user'] ?? '-')),
                            DataCell(Text('\$${p['amount'].toString()}')),
                            DataCell(Text(p['method'] ?? '')),
                            DataCell(Text(
                              p['status'],
                              style: TextStyle(
                                color: p['status'] == 'Completado'
                                    ? Colors.green
                                    : p['status'] == 'Pendiente'
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            )),
                            DataCell(Text(p['date'] ?? '')),
                          ]);
                        }).toList(),
                      ),
                    ),
    );
  }
}
