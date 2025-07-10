import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../services/payment_service.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  late Future<List<Map<String, dynamic>>> _paymentsFuture;

  @override
  void initState() {
    super.initState();
    _paymentsFuture = PaymentService.getPayments(); // 👈 Usa tu servicio
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '💰 Pagos y Transacciones',
      currentRoute: '/payments',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen mensual',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const _MonthlySummaryRow(),
            const SizedBox(height: 32),
            const Text(
              'Historial de transacciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    return Center(child: Text('❌ Error: ${snapshot.error}'));
                  }

                  final payments = snapshot.data!;
                  if (payments.isEmpty) {
                    return const Center(child: Text('No hay pagos registrados.'));
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
                      rows: payments.map((p) {
                        return DataRow(cells: [
                          DataCell(Text(p['id'].toString())),
                          DataCell(Text(p['user'] ?? 'N/A')),
                          DataCell(Text('\$${p['amount']}')),
                          DataCell(Text(p['date'] ?? '')),
                          DataCell(Text(p['status'] ?? '')),
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

// ----------------- 📊 CARD ROW RESUMEN MENSUAL ------------------

class _MonthlySummaryRow extends StatelessWidget {
  const _MonthlySummaryRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: PaymentSummaryCard(
            label: 'Total Ingresos',
            value: '\$8,320',
            color: Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: PaymentSummaryCard(
            label: 'Pagos Enviados',
            value: '\$4,120',
            color: Colors.indigo,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: PaymentSummaryCard(
            label: 'Pendientes',
            value: '\$2,300',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class PaymentSummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const PaymentSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

