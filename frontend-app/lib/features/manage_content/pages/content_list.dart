import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../services/content_service.dart';

class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  late Future<List<ContentModel>> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = ContentService().fetchAllContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contenido Público")),
      body: FutureBuilder<List<ContentModel>>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay contenido disponible.'));
          }

          final contents = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final content = contents[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(content.title),
                  subtitle: Text(content.type.toUpperCase()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navegar a detalle si se desea
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
