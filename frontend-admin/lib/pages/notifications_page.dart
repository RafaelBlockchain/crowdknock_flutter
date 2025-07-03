import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          _buildSidebar(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🔔 Notifications',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),

                  _buildNotificationForm(),
                  const SizedBox(height: 32),
                  _buildRecentNotificationsTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar
  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 24),
          _navLink('Dashboard', false),
          _navLink('Moderation', false),
          _navLink('Analytics', false),
          _navLink('Reports', false),
          _navLink('Payments', false),
          _navLink('Activity Logs', false),
          _navLink('System Status', false),
          _navLink('Notifications', true),
          _navLink('Settings', false),
        ],
      ),
    );
  }

  // Navigation Link Widget
  Widget _navLink(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.centerLeft,
          backgroundColor: isActive ? Colors.indigo : Colors.transparent,
          foregroundColor: isActive ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          // Aquí puedes agregar lógica de navegación si es necesario
        },
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // Formulario para enviar notificaciones
  Widget _buildNotificationForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Send New Notification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          _formFieldLabel('Target Audience'),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: 'all',
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All Users')),
              DropdownMenuItem(value: 'active', child: Text('Active Users')),
              DropdownMenuItem(value: 'inactive', child: Text('Inactive Users')),
              DropdownMenuItem(value: 'custom', child: Text('Custom Email List')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),

          _formFieldLabel('Title'),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Notification title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          _formFieldLabel('Message'),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your message here...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              // Enviar notificación (conexión al backend)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Send Notification'),
          )
        ],
      ),
    );
  }

  // Tabla de notificaciones recientes
  Widget _buildRecentNotificationsTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Notifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Target')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _notificationRow('2025-06-28', 'Maintenance Notice', 'All Users', 'Sent',
                    color: Colors.green),
                _notificationRow('2025-06-27', 'Poll Results', 'Active Users', 'Sent',
                    color: Colors.green),
                _notificationRow('2025-06-25', 'New Feature Update', 'Custom', 'Scheduled',
                    color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Etiqueta de campo de formulario
  Widget _formFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 12.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }

  // Fila de tabla
  DataRow _notificationRow(
    String date,
    String title,
    String target,
    String status, {
    Color color = Colors.black,
  }) {
    return DataRow(cells: [
      DataCell(Text(date)),
      DataCell(Text(title)),
      DataCell(Text(target)),
      DataCell(Text(status, style: TextStyle(color: color))),
    ]);
  }
}
