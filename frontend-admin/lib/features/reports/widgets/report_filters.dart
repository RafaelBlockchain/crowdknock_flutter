import 'package:flutter/material.dart';

class ReportFilters extends StatelessWidget {
  final String? selectedType;
  final String? selectedStatus;
  final Function(String?) onTypeChanged;
  final Function(String?) onStatusChanged;

  const ReportFilters({
    super.key,
    required this.selectedType,
    required this.selectedStatus,
    required this.onTypeChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        DropdownButton<String>(
          value: selectedType,
          hint: const Text('Filtrar por tipo'),
          items: const [
            DropdownMenuItem(value: 'content', child: Text('Contenido')),
            DropdownMenuItem(value: 'user', child: Text('Usuario')),
            DropdownMenuItem(value: 'other', child: Text('Otro')),
          ],
          onChanged: onTypeChanged,
        ),
        DropdownButton<String>(
          value: selectedStatus,
          hint: const Text('Filtrar por estado'),
          items: const [
            DropdownMenuItem(value: 'pending', child: Text('Pendiente')),
            DropdownMenuItem(value: 'reviewed', child: Text('Revisado')),
            DropdownMenuItem(value: 'resolved', child: Text('Resuelto')),
          ],
          onChanged: onStatusChanged,
        ),
      ],
    );
  }
}
