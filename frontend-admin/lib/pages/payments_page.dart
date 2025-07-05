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
      title: '💰 Payments',
      currentRoute: '/payments',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const _MonthlySummaryRow(),
            const SizedBox(height: 32),
            const Text(
              'Recent Transactions',
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
                    return const Center(child: Text('No payments found.'));
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('User')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: payments.map((payment) {
                        return DataRow(cells: [
                          DataCell(Text(payment['id'].toString())),
                          DataCell(Text(payment['user'] ?? 'N/A')),
                          DataCell(Text('\$${payment['amount']}')),
                          DataCell(Text(payment['date'] ?? '')),
                          DataCell(Text(payment['status'] ?? '')),
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

// --------------------- CARDS: MONTHLY SUMMARY ---------------------

class _MonthlySummaryRow extends StatelessWidget {
  const _MonthlySummaryRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(child: PaymentSummaryCard(label: 'Total Revenue', value: '\$8,320', color: Colors.green)),
        SizedBox(width: 16),
        Expanded(child: PaymentSummaryCard(label: 'Total Payouts', value: '\$4,120', color: Colors.indigo)),
        SizedBox(width: 16),
        Expanded(child: PaymentSummaryCard(label: 'Pending', value: '\$2,300', color: Colors.orange)),
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
            Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
