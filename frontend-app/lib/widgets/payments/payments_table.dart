// frontend-admin/lib/widgets/payments/payments_table.dart

import 'package:flutter/material.dart';

class PaymentsTable extends StatelessWidget {
  const PaymentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos simulados por ahora
    final payments = [
      {'id': '1', 'user': 'Juan Pérez', 'amount': 59.99, 'status': 'paid', 'date': '2025-07-04'},
      {'id': '2', 'user': 'Ana López', 'amount': 29.99, 'status': 'pending', 'date': '2025-07-03'},
    ];

    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Usuario')),
          DataColumn(label: Text('Monto')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Fecha')),
        ],
        rows: payments.map((p) {
          return DataRow(cells: [
            DataCell(Text(p['id']!)),
            DataCell(Text(p['user']!)),
            DataCell(Text('\$${p['amount']}')),
            DataCell(Text(p['status']!)),
            DataCell(Text(p['date']!)),
          ]);
        }).toList(),
      ),
    );
  }
}
