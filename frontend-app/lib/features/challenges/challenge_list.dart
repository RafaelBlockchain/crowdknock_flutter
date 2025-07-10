import 'package:flutter/material.dart';
import 'challenge_detail.dart';

class ChallengeListPage extends StatelessWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación local. En producción, usar datos reales desde backend.
    final challenges = [
      {
        'id': '1',
        'title': 'Reto: Denuncia ciudadana',
        'description': 'Sube evidencia sobre un problema en tu comunidad.',
        'status': 'Activo',
      },
      {
        'id': '2',
        'title': 'Reto: Opinión ciudadana',
        'description': 'Comparte tu opinión sobre la justicia en tu zona.',
        'status': 'Finalizado',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Retos disponibles'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final challenge = challenges[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(challenge['title'] ?? ''),
              subtitle: Text(challenge['description'] ?? ''),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChallengeDetailPage(
                      challengeId: challenge['id']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

