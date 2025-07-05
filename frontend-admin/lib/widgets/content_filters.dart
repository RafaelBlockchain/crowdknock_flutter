import 'package:flutter/material.dart';

class ContentFilters extends StatelessWidget {
  final String selectedType;
  final String selectedStatus;
  final String selectedDate;
  final Function(String) onTypeChanged;
  final Function(String) onStatusChanged;
  final Function(String) onDateChanged;

  const ContentFilters({
    super.key,
    required this.selectedType,
    required this.selectedStatus,
    required this.selectedDate,
    required this.onTypeChanged,
    required this.onStatusChanged,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        DropdownButton<String>(
          value: selectedType,
          onChanged: (value) => onTypeChanged(value!),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('📁 Todos los tipos')),
            DropdownMenuItem(value: 'Video', child: Text('🎥 Video')),
            DropdownMenuItem(value: 'Audio', child: Text('🎧 Audio')),
            DropdownMenuItem(value: 'Story', child: Text('📖 Historia')),
          ],
        ),
        DropdownButton<String>(
          value: selectedStatus,
          onChanged: (value) => onStatusChanged(value!),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('📌 Todos los estados')),
            DropdownMenuItem(value: 'Published', child: Text('✅ Publicado')),
            DropdownMenuItem(value: 'Draft', child: Text('📝 Borrador')),
            DropdownMenuItem(value: 'Archived', child: Text('🗂 Archivado')),
          ],
        ),
        DropdownButton<String>(
          value: selectedDate,
          onChanged: (value) => onDateChanged(value!),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('📅 Todas las fechas')),
            DropdownMenuItem(value: 'Last7Days', child: Text('Últimos 7 días')),
            DropdownMenuItem(value: 'Last30Days', child: Text('Últimos 30 días')),
            DropdownMenuItem(value: 'ThisYear', child: Text('Este año')),
          ],
        ),
      ],
    );
  }
}
