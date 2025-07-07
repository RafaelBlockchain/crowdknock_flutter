import 'package:flutter/material.dart';

class PaymentsTable extends StatelessWidget {
  const PaymentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = [
      {
        'id': 'TXN001',
        'user': 'Juan Pérez',
        'amount': 29.99,
        'status': 'Completado',
        'date': '2025-07-01',
      },
      {
        'id': 'TXN002',
        'user': 'Laura Gómez',
        'amount': 49.99,
        'status': 'Pendiente',
        'date': '2025-07-02',
      },
      {
        'id': 'TXN003',
        'user': 'Carlos Ruiz',
        'amount': 9.99,
        'status': 'Fallido',
        'date': '2025-07-03',
      },
    ];

    return SingleChildScrollView(
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
            DataCell(Text(payment['id']!)),
            DataCell(Text(payment['user']!)),
            DataCell(Text('\$${payment['amount']}')),
            DataCell(Text(payment['status']!)),
            DataCell(Text(payment['date']!)),
          ]);
        }).toList(),
      ),
    );
  }
}
