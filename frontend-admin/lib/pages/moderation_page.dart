import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';
import 'widgets/moderation_table.dart';
import 'widgets/reported_comment_card.dart';
import 'widgets/reported_content_preview.dart';

class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Moderación de Contenido',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔎 Reportes recientes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ModerationTable(), // ✅ Tabla con acciones por fila

            const SizedBox(height: 32),

            const Text(
              '🗨 Comentario reportado (Ejemplo)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const ReportedCommentCard(
              comment: 'Este contenido es ofensivo.',
              reason: 'Lenguaje inapropiado',
            ),

            const SizedBox(height: 24),

            const Text(
              '📸 Contenido reportado (Ejemplo)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const ReportedContentPreview(
              content: {
                'title': 'Video polémico sobre X',
                'type': 'video',
                'thumbnail': 'https://via.placeholder.com/150', // Puedes reemplazarlo
              },
            ),
          ],
        ),
      ),
    );
  }
}
