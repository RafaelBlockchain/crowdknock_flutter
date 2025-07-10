import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🔔 Notificaciones',
      currentRoute: '/notifications',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Centro de Notificaciones',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),

            _NotificationForm(),
            const SizedBox(height: 32),

            _RecentNotificationsTable(),
          ],
        ),
      ),
    );
  }
}

class _NotificationForm extends StatelessWidget {
  const _NotificationForm();

  @override
  Widget build(BuildContext context) {
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
          const Text('Enviar Nueva Notificación',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          _formLabel('Audiencia objetivo'),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: 'all',
            items: const [
              DropdownMenuItem(value: 'all', child: Text('Todos los usuarios')),
              DropdownMenuItem(value: 'active', child: Text('Usuarios activos')),
              DropdownMenuItem(value: 'inactive', child: Text('Usuarios inactivos')),
              DropdownMenuItem(value: 'custom', child: Text('Lista personalizada')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),

          _formLabel('Título'),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Título de la notificación',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          _formLabel('Mensaje'),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Escribe el mensaje aquí...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              // TODO: Llamar a POST /api/notifications
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('📨 Notificación enviada')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            icon: const Icon(Icons.send),
            label: const Text('Enviar Notificación'),
          )
        ],
      ),
    );
  }

  Widget _formLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 12.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }
}

class _RecentNotificationsTable extends StatelessWidget {
  const _RecentNotificationsTable();

  @override
  Widget build(BuildContext context) {
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
          const Text('Notificaciones Recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Título')),
                DataColumn(label: Text('Destino')),
                DataColumn(label: Text('Estado'

