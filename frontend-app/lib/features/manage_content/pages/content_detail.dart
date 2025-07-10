import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../services/content_service.dart';

class ContentDetailPage extends StatefulWidget {
  final String contentId;

  const ContentDetailPage({super.key, required this.contentId});

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  late Future<ContentModel> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = ContentService().fetchContentById(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Contenido")),
      body: FutureBuilder<ContentModel>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Contenido no disponible.'));
          }

          final content = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content.title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Tipo: ${content.type}", style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text("Autor: ${content.author}"),
                const SizedBox(height: 8),
                Text("Fecha: ${content.createdAt.toLocal().toString().substring(0, 16)}"),
                const SizedBox(height: 24),
                if (content.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(content.imageUrl!),
                  ),
                const SizedBox(height: 24),
                Text(
                  content.body,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

  }
}
