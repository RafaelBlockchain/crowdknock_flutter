import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';
import 'package:frontend_app/features/payments/widgets/payments_table.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminScaffold(
      title: 'Gestión de Pagos',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: PaymentsTable(),
      ),
    );
  }
}
