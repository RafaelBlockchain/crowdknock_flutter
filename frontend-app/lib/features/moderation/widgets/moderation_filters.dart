import 'package:flutter/material.dart';

class ModerationFilters extends StatefulWidget {
  final void Function(String type, String status) onFilterChanged;

  const ModerationFilters({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<ModerationFilters> createState() => _ModerationFiltersState();
}

class _ModerationFiltersState extends State<ModerationFilters> {
  String selectedType = 'Todos';
  String selectedStatus = 'Todos';

  final List<String> contentTypes = ['Todos', 'Video', 'Comentario', 'Audio'];
  final List<String> statusTypes = ['Todos', 'Pendiente', 'Aprobado', 'Rechazado'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        DropdownButton<String>(
          value: selectedType,
          items: contentTypes.map((type) {
            return DropdownMenuItem(value: type, child: Text(type));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedType = value;
              });
              widget.onFilterChanged(selectedType, selectedStatus);
            }
          },
          hint: const Text('Tipo de contenido'),
        ),
        DropdownButton<String>(
          value: selectedStatus,
          items: statusTypes.map((status) {
            return DropdownMenuItem(value: status, child: Text(status));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedStatus = value;
              });
              widget.onFilterChanged(selectedType, selectedStatus);
            }
          },
          hint: const Text('Estado del reporte'),
        ),
      ],
    );
  }
}
