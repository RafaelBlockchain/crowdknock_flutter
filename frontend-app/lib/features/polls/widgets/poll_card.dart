import 'package:flutter/material.dart';
import '../models/poll_model.dart';
import '../ui/poll_detail_page.dart';

class PollCard extends StatelessWidget {
  final PollModel poll;

  const PollCard({super.key, required this.poll});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(poll.question),
        subtitle: Text(
          "Opciones: ${poll.options.length}",
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PollDetailPage(pollId: poll.id),
            ),
          );
        },
      ),
    );
  }
}

