import 'package:flutter/material.dart';
import '../models/poll_model.dart';
import '../services/poll_service.dart';
import '../widgets/poll_card.dart';

class PollListPage extends StatefulWidget {
  const PollListPage({super.key});

  @override
  State<PollListPage> createState() => _PollListPageState();
}

class _PollListPageState extends State<PollListPage> {
  late Future<List<PollModel>> _pollsFuture;

  @override
  void initState() {
    super.initState();
    _pollsFuture = PollService().fetchPolls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Encuestas Activas")),
      body: FutureBuilder<List<PollModel>>(
        future: _pollsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay encuestas disponibles."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return PollCard(poll: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}

