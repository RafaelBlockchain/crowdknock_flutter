import 'package:flutter/material.dart';

class ModerationActions extends StatelessWidget {
  final Map<String, dynamic> report;

  const ModerationActions({super.key, required this.report});

  void _approve(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Reporte ${report['id']} aprobado')),
    );
  }

  void _delete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🗑️ Contenido ${report['id']} eliminado')),
    );
  }

  void _ignore(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🙈 Reporte ${report['id']} ignorado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.check, color: Colors.green),
          tooltip: 'Aprobar',
          onPressed: () => _approve(context),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Eliminar',
          onPressed: () => _delete(context),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
          tooltip: 'Ignorar',
          onPressed: () => _ignore(context),
        ),
      ],
    );
  }
}
