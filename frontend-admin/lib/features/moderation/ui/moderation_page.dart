import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';
import '../widgets/moderation_table.dart';
import '../widgets/reported_comment_card.dart';
import '../widgets/reported_content_preview.dart';

class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛠 Moderación de Contenido',
      currentRoute: '/moderation',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔎 Reportes Recientes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 📄 Tabla dinámica con reportes
            const ModerationTable(),

            const SizedBox(height: 32),
            const Divider(),

            // 🗨 Comentario reportado de ejemplo
            const Text(
              '🗨 Comentario Reportado (Ejemplo)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ReportedCommentCard(
              comment: 'Este contenido es ofensivo.',
              reason: 'Lenguaje inapropiado',
            ),

            const SizedBox(height: 24),

            // 📸 Contenido reportado de ejemplo
            const Text(
              '📸 Contenido Reportado (Ejemplo)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ReportedContentPreview(
              content: {
                'title': 'Video polémico sobre X',
                'type': 'video',
                'thumbnail': 'https://via.placeholder.com/150',
              },
            ),
          ],
        ),
      ),
    );
  }
}

