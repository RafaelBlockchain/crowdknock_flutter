import 'package:flutter/material.dart';

class ReportedContentPreview extends StatelessWidget {
  final Map<String, dynamic> content;

  const ReportedContentPreview({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    String type = content['type'] ?? 'unknown';
    String title = content['title'] ?? 'Sin título';
    String thumbnailUrl = content['thumbnail'] ?? '';

    IconData icon;
    switch (type) {
      case 'video':
        icon = Icons.videocam;
        break;
      case 'audio':
        icon = Icons.audiotrack;
        break;
      case 'image':
        icon = Icons.image;
        break;
      default:
        icon = Icons.article;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          if (thumbnailUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                thumbnailUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Icon(icon, size: 40, color: Colors.grey[600]),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('📁 Tipo: $type', style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
