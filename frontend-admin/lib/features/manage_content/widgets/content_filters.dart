import 'package:flutter/material.dart';

class ContentFilters extends StatefulWidget {
  final Function(String type, String status) onFilterChanged;

  const ContentFilters({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<ContentFilters> createState() => _ContentFiltersState();
}

class _ContentFiltersState extends State<ContentFilters> {
  String _selectedType = 'Todos';
  String _selectedStatus = 'Todos';

  final List<String> _types = ['Todos', 'Video', 'Audio', 'Historia'];
  final List<String> _statuses = ['Todos', 'Publicado', 'Pendiente', 'Rechazado'];

  void _applyFilters() {
    widget.onFilterChanged(
      _selectedType == 'Todos' ? '' : _selectedType.toLowerCase(),
      _selectedStatus == 'Todos' ? '' : _selectedStatus.toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        DropdownButton<String>(
          value: _selectedType,
          onChanged: (value) {
            setState(() {
              _selectedType = value!;
            });
            _applyFilters();
          },
          items: _types.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value!;
            });
            _applyFilters();
          },
          items: _statuses.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status),
            );
          }).toList(),
        ),
      ],
    );
  }
}
