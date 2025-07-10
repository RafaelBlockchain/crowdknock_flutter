import 'package:flutter/material.dart';
import '../models/challenge.dart';
import '../repositories/challenge_repository.dart';
import 'challenge_detail.dart';

class ChallengeListPage extends StatefulWidget {
  const ChallengeListPage({super.key});

  @override
  State<ChallengeListPage> createState() => _ChallengeListPageState();
}

class _ChallengeListPageState extends State<ChallengeListPage> {
  late Future<List<Challenge>> _challengesFuture;

  @override
  void initState() {
    super.initState();
    _challengesFuture = ChallengeRepository().fetchAllChallenges();
  }

  void openDetail(Challenge challenge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChallengeDetailPage(challengeId: challenge.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retos Disponibles')),
      body: FutureBuilder<List<Challenge>>(
        future: _challengesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay retos disponibles.'));
          }

          final challenges = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              final challenge = challenges[index];
              return Card(
                child: ListTile(
                  title: Text(challenge.title),
                  subtitle: Text(challenge.description),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => openDetail(challenge),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
