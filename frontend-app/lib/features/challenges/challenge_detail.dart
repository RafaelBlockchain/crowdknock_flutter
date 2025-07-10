import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String challengeId;

  const ChallengeDetailPage({super.key, required this.challengeId});

  @override
  Widget build(BuildContext context) {
    // TODO: Reemplazar con lógica real de fetching desde API
    final fakeChallenge = {
      'title': 'Reto: Documentar una denuncia',
      'description': 'Completa el formulario y sube la evidencia del caso.',
      'createdAt': '2025-07-10',
      'status': 'Activo',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fakeChallenge['title']!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Estado: ${fakeChallenge['status']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              fakeChallenge['description']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Publicado el: ${fakeChallenge['createdAt']}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Acción para participar o enviar contenido
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('¡Participación registrada!')),
                );
              },
              icon: Icon(Icons.check_circle_outline),
              label: Text('Participar en el Challenge'),
            )
          ],
        ),
      ),
    );
  }
}

