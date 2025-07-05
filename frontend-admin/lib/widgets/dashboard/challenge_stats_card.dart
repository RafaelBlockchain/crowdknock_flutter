import 'package:flutter/material.dart';

class ChallengeStatsCard extends StatelessWidget {
  final int active;
  final int completed;
  final int pendingReview;

  const ChallengeStatsCard({
    super.key,
    required this.active,
    required this.completed,
    required this.pendingReview,
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
              '🎯 Desafíos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem('Activos', active, Colors.teal),
                _buildItem('Completados', completed, Colors.purple),
                _buildItem('Pendientes', pendingReview, Colors.redAccent),
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
