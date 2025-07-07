import 'package:flutter/material.dart';
import 'package:frontend_app/features/payments/models/payment_model.dart';
import 'package:frontend_app/features/payments/services/payments_service.dart';

class PaymentsTable extends StatefulWidget {
  const PaymentsTable({super.key});

  @override
  State<PaymentsTable> createState() => _PaymentsTableState();
}

class _PaymentsTableState extends State<PaymentsTable> {
  final PaymentsService _paymentsService = PaymentsService();
  late Future<List<Payment>> _paymentsFuture;

  @override
  void initState() {
    super.initState();
    _paymentsFuture = _paymentsService.getAllPayments();
  }

  Future<void> _refreshPayments() async {
    setState(() {
      _paymentsFuture = _paymentsService.getAllPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Payment>>(
      future: _paymentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final payments = snapshot.data!;
        if (payments.isEmpty) {
          return const Center(child: Text('No hay pagos registrados.'));
        }

        return RefreshIndicator(
          onRefresh: _refreshPayments,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID Transacción')),
                DataColumn(label: Text('Usuario')),
                DataColumn(label: Text('Monto')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Fecha')),
              ],
              rows: payments.map((payment) {
                return DataRow(cells: [
                  DataCell(Text(payment.id)),
                  DataCell(Text(payment.user)),
                  DataCell(Text('\$${payment.amount.toStringAsFixed(2)}')),
                  DataCell(Text(payment.status)),
                  DataCell(Text(payment.date)),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
