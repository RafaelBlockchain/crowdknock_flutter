import 'package:flutter/material.dart';

class ChallengeSubmissionPage extends StatefulWidget {
  final String challengeId;

  const ChallengeSubmissionPage({super.key, required this.challengeId});

  @override
  State<ChallengeSubmissionPage> createState() => _ChallengeSubmissionPageState();
}

class _ChallengeSubmissionPageState extends State<ChallengeSubmissionPage> {
  final TextEditingController commentCtrl = TextEditingController();
  bool isSubmitting = false;

  void submitChallenge() async {
    setState(() => isSubmitting = true);

    try {
      // TODO: Lógica real para enviar participación (API POST)
      await Future.delayed(const Duration(seconds: 2)); // Simula red

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Participación enviada con éxito')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar: $e')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Participar en el Reto")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: commentCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Comentario o explicación",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            isSubmitting
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: submitChallenge,
                    icon: const Icon(Icons.send),
                    label: const Text("Enviar participación"),
                  ),
          ],
        ),
      ),
    );
  }
}
