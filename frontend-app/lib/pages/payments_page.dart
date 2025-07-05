// frontend-admin/lib/pages/payments_page.dart

import 'package:flutter/material.dart';
import '../widgets/admin_scaffold.dart';
import '../widgets/payments/payments_table.dart';
import '../widgets/payments/payments_filters.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Gestión de Pagos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PaymentsFilters(),
          SizedBox(height: 16),
          Expanded(child: PaymentsTable()),
        ],
      ),
    );
  }
}
