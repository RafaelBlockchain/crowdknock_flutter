import 'package:flutter/material.dart';

class ContentRowActions extends StatelessWidget {
  final Map<String, dynamic> content;

  const ContentRowActions({super.key, required this.content});

  void _onEdit(BuildContext context) {
    // Aquí abrirás el EditContentDialog en el futuro
    debugPrint('Editar contenido ID: ${content['id']}');
  }

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de eliminar "${content['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí implementarás la lógica real de eliminación
              debugPrint('Contenido eliminado ID: ${content['id']}');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          tooltip: 'Editar',
          onPressed: () => _onEdit(context),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Eliminar',
          onPressed: () => _onDelete(context),
        ),
      ],
    );
  }
}
