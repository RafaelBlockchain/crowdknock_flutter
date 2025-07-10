import 'package:flutter/material.dart';
import '../models/challenge_submission_request.dart';
import '../repositories/challenge_repository.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class ChallengeSubmissionPage extends StatefulWidget {
  final String challengeId;

  const ChallengeSubmissionPage({super.key, required this.challengeId});

  @override
  State<ChallengeSubmissionPage> createState() => _ChallengeSubmissionPageState();
}

class _ChallengeSubmissionPageState extends State<ChallengeSubmissionPage> {
  final TextEditingController commentCtrl = TextEditingController();
  bool isSubmitting = false;

  File? selectedFile;

Future<void> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  );

  if (result != null && result.files.single.path != null) {
    setState(() {
      selectedFile = File(result.files.single.path!);
    });
  }
}

  void submitChallenge() async {
  if (commentCtrl.text.trim().isEmpty) return;

  setState(() => isSubmitting = true);

  try {
    final data = ChallengeSubmissionRequest(comment: commentCtrl.text.trim());
    await ChallengeRepository().submitParticipation(widget.challengeId, data);

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
      body:
      TextButton.icon(
  onPressed: pickFile,
  icon: const Icon(Icons.attach_file),
  label: const Text("Adjuntar evidencia"),
),
if (selectedFile != null)
  Text(
    'Archivo: ${selectedFile!.path.split('/').last}',
    style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
),

      Padding(
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
