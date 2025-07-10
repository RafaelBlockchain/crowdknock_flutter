import 'package:flutter/material.dart';

class ManageContentScreen extends StatefulWidget {
  const ManageContentScreen({super.key});

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  // Datos simulados por ahora
  final List<Map<String, dynamic>> contents = [
    {
      'id': 1,
      'title': 'Normativa Ambiental',
      'type': 'Artículo',
      'status': 'Publicado',
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 2,
      'title': 'Guía de Procedimientos Judiciales',
      'type': 'PDF',
      'status': 'Pendiente',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    },
  ];

  void _createNewContent() {
    // Acción para navegar al formulario de creación
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de creación en desarrollo')),
    );
  }

  void _editContent(int id) {
    // Acción de edición por ID
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editar contenido ID: $id')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Contenidos'),
        backgroundColor: Colors.indigo,
      ),
      body: contents.isEmpty
          ? const Center(child: Text('No hay contenidos registrados.'))
          : ListView.builder(
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final content = contents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(content['title']),
                    subtitle: Text(
                      'Tipo: ${content['type']} • '
                      'Estado: ${content['status']} • '
                      'Creado: ${content['createdAt'].toString().split(' ')[0]}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editContent(content['id']),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewContent,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        tooltip: 'Nuevo contenido',
      ),
    );
  }
}

