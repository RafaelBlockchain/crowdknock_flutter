import 'package:flutter/material.dart';

class ContentStatsCard extends StatelessWidget {
  final int videos;
  final int audios;
  final int stories;

  const ContentStatsCard({
    super.key,
    required this.videos,
    required this.audios,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📦 Contenidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem('🎬 Videos', videos, Colors.blue),
                _buildItem('🎧 Audios', audios, Colors.green),
                _buildItem('📖 Historias', stories, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, int count, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label),
      ],
    );
  }
}
