import 'package:flutter/material.dart';

class ContentFilters extends StatelessWidget {
  final String selectedType;
  final String selectedStatus;
  final void Function(String, String) onFilterChanged;

  const ContentFilters({
    super.key,
    required this.selectedType,
    required this.selectedStatus,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final types = ['Todos', 'Video', 'Audio', 'Texto'];
    final statuses = ['Todos', 'Publicado', 'Pendiente', 'Rechazado'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedType,
            onChanged: (value) {
              if (value != null) {
                onFilterChanged(value, selectedStatus);
              }
            },
            items: types.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            hint: const Text('Tipo'),
          ),
          DropdownButton<String>(
            value: selectedStatus,
            onChanged: (value) {
              if (value != null) {
                onFilterChanged(selectedType, value);
              }
            },
            items: statuses.map((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            hint: const Text('Estado'),
          ),
        ],
      ),
    );
  }
}

