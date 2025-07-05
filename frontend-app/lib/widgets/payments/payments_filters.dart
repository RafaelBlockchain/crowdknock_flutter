// frontend-admin/lib/widgets/payments/payments_filters.dart

import 'package:flutter/material.dart';

class PaymentsFilters extends StatelessWidget {
  const PaymentsFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Estado'),
          items: const [
            DropdownMenuItem(value: 'all', child: Text('Todos')),
            DropdownMenuItem(value: 'paid', child: Text('Pagado')),
            DropdownMenuItem(value: 'pending', child: Text('Pendiente')),
            DropdownMenuItem(value: 'failed', child: Text('Fallido')),
          ],
          onChanged: (value) {},
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Lógica de filtro aquí
          },
          icon: const Icon(Icons.search),
          label: const Text('Filtrar'),
        ),
      ],
    );
  }
}
