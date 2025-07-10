import 'package:flutter/material.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // 🔹 Sidebar
          Container(
            width: 260,
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CrowdKnock Admin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const SizedBox(height: 32),
                ..._sidebarItems.map((item) {
                  final isActive = item == 'Email Templates';
                  return _buildSidebarLink(context, item, isActive);
                }).toList(),
              ],
            ),
          ),

          // 🔹 Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📨 Email Templates', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),

                  _buildTemplatesTable(),
                  const SizedBox(height: 40),
                  _buildTemplateForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Sidebar link builder
  Widget _buildSidebarLink(BuildContext context, String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: active ? Colors.indigo : Colors.transparent,
          foregroundColor: active ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          // TODO: Navegar según ruta definida
          // Navigator.pushReplacementNamed(context, '/templates');
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
      ),
    );
  }

  // 🔹 Tabla de plantillas
  Widget _buildTemplatesTable() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📂 Plantillas Disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Asunto')),
                  DataColumn(label: Text('Actualizado')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: [
                  _buildTemplateRow('Welcome Email', 'Welcome to CrowdKnock!', '2025-06-20'),
                  _buildTemplateRow('Password Reset', 'Reset Your Password', '2025-06-15'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildTemplateRow(String name, String subject, String date) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(subject)),
        DataCell(Text(date)),
        DataCell(Row(
          children: [
            TextButton(
              onPressed: () {
                // TODO: Cargar datos al formulario para editar
              },
              child: const Text('Editar', style: TextStyle(color: Colors.indigo)),
            ),
            TextButton(
              onPressed: () {
                // TODO: Confirmar y eliminar plantilla
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        )),
      ],
    );
  }

  // 🔹 Formulario de creación/edición
  Widget _buildTemplateForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('✏️ Crear / Editar Plantilla', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de la plantilla',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Asunto del correo',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Contenido HTML o texto plano',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Guardar plantilla
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar Plantilla'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Sidebar items
  List<String> get _sidebarItems => [
        'Dashboard',
        'Manage Users',
        'Manage Content',
        'Moderation',
        'Analytics',
        'Reports',
        'Payments',
        'Email Templates',
        'Settings',
        'Audit Logs',
        'System Status',
        'Admin Logins',
        'Role Management',
      ];
}

