import 'package:flutter/material.dart';
import '../services/poll_service.dart';
import '../models/poll_model.dart';

class PollDetailPage extends StatefulWidget {
  final String pollId;

  const PollDetailPage({super.key, required this.pollId});

  @override
  State<PollDetailPage> createState() => _PollDetailPageState();
}

class _PollDetailPageState extends State<PollDetailPage> {
  late Future<PollModel> _pollFuture;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _pollFuture = PollService().fetchPollById(widget.pollId);
  }

  void _submitVote(String optionId) async {
    await PollService().vote(widget.pollId, optionId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Voto registrado correctamente")),
    );
    setState(() {
      _pollFuture = PollService().fetchPollById(widget.pollId);
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle de Encuesta")),
      body: FutureBuilder<PollModel>(
        future: _pollFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Encuesta no disponible."));
          }

          final poll = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(poll.question, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 24),
                ...poll.options.map((option) {
                  return RadioListTile<String>(
                    title: Text(option.text),
                    value: option.id,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() => _selectedOption = value);
                    },
                  );
                }).toList(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _selectedOption == null
                      ? null
                      : () => _submitVote(_selectedOption!),
                  child: const Text("Votar"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

