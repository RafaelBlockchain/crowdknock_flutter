import 'package:flutter/material.dart';
import '../../../data/models/content_model.dart';

class ContentRowActions extends StatelessWidget {
  final ContentModel content;
  final void Function(ContentModel) onEdit;
  final void Function(ContentModel) onDelete;

  const ContentRowActions({
    super.key,
    required this.content,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Editar',
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => onEdit(content),
        ),
        IconButton(
          tooltip: 'Eliminar',
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete(content),
        ),
      ],
    );
  }
}
