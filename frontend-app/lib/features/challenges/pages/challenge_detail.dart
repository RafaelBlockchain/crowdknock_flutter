import 'package:flutter/material.dart';
import 'challenge_submission.dart';
import '../models/challenge.dart';
import '../repositories/challenge_repository.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String challengeId;

  const ChallengeDetailPage({super.key, required this.challengeId});

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  late Future<Challenge> _challengeFuture;

  @override
  void initState() {
    super.initState();
    _challengeFuture = ChallengeRepository().fetchChallenge(widget.challengeId);
  }

  void goToSubmission() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeSubmissionPage(challengeId: widget.challengeId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Challenge')),
      body: FutureBuilder<Challenge>(
        future: _challengeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Challenge no encontrado.'));
          }

          final challenge = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenge.title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                Text('Estado: ${challenge.status}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(challenge.description),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: goToSubmission,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Participar'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
