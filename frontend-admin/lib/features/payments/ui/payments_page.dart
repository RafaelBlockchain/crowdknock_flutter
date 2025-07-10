import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../services/payment_service.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late Future<List<Map<String, dynamic>>> _paymentsFuture;

  @override
  void initState() {
    super.initState();
    _paymentsFuture = PaymentService.getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '💰 Pagos',
      currentRoute: '/payments',
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen Mensual',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const _MonthlySummaryRow(),
            const SizedBox(height: 32),
            const Text(
              'Transacciones Recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _paymentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('❌ Error al cargar pagos: ${snapshot.error}'),
                    );
                  }

                  final payments = snapshot.data!;
                  if (payments.isEmpty) {
                    return const Center(child: Text('No se encontraron transacciones.'));
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Usuario')),
                        DataColumn(label: Text('Monto')),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Estado')),
                      ],
                      rows: payments.map((payment) {
                        return DataRow(cells: [
                          DataCell(Text(payment['id'].toString())),
                          DataCell(Text(payment['user'] ?? 'N/A')),
                          DataCell(Text('\$${payment['amount']}')),
                          DataCell(Text(payment['date'] ?? '-')),
                          DataCell(
                            Text(
                              payment['status'] ?? '',
                              style: TextStyle(
                                color: payment['status'] == 'Pendiente'
                                    ? Colors.orange
                                    : payment['status'] == 'Fallido'
                                        ? Colors.red
                                        : Colors.green,
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

