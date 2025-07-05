import 'package:flutter/material.dart';
import 'package:frontend_admin/layout/admin_scaffold.dart';
import 'package:frontend_admin/services/system_status_service.dart';

class SystemStatusPage extends StatefulWidget {
  const SystemStatusPage({super.key});

  @override
  State<SystemStatusPage> createState() => _SystemStatusPageState();
}

class _SystemStatusPageState extends State<SystemStatusPage> {
  Map<String, dynamic>? systemHealth;
  List<Map<String, dynamic>> serviceStatuses = [];
  Map<String, dynamic>? serverMetrics;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final health = await SystemStatusService.getSystemHealth();
      final services = await SystemStatusService.getServiceStatuses();
      final metrics = await SystemStatusService.getServerMetrics();

      setState(() {
        systemHealth = health;
        serviceStatuses = services;
        serverMetrics = metrics;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading system status: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Estado del Sistema',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHealthCard(),
                  const SizedBox(height: 20),
                  _buildServiceStatusTable(),
                  const SizedBox(height: 20),
                  _buildServerMetrics(),
                ],
              ),
            ),
    );
  }

  Widget _buildHealthCard() {
    if (systemHealth == null) return const SizedBox();

    return Card(
      child: ListTile(
        leading: Icon(
          systemHealth!['status'] == 'ok' ? Icons.check_circle : Icons.warning,
          color: systemHealth!['status'] == 'ok' ? Colors.green : Colors.red,
        ),
        title: Text('Estado General: ${systemHealth!['status']}'),
        subtitle: Text('Uptime: ${systemHealth!['uptime']} • Versión: ${systemHealth!['version']}'),
      ),
    );
  }

  Widget _buildServiceStatusTable() {
    if (serviceStatuses.isEmpty) return const Text('No se encontraron servicios.');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Servicios Internos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DataTable(
          columns: const [
            DataColumn(label: Text('Servicio')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Detalles')),
          ],
          rows: serviceStatuses.map((service) {
            final isUp = service['status'] == 'ok';
            return DataRow(cells: [
              DataCell(Text(service['name'])),
              DataCell(Row(
                children: [
                  Icon(isUp ? Icons.check : Icons.close,
                      color: isUp ? Colors.green : Colors.red),
                  const SizedBox(width: 4),
                  Text(service['status']),
                ],
              )),
              DataCell(Text(service['details'] ?? '-')),
            ]);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildServerMetrics() {
    if (serverMetrics == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Métricas del Servidor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _metricTile('CPU %', serverMetrics!['cpu']?.toString() ?? '--'),
            _metricTile('Memoria', serverMetrics!['memory'] ?? '--'),
            _metricTile('Conexiones', serverMetrics!['connections'].toString()),
            _metricTile('Uso Disco', serverMetrics!['disk'] ?? '--'),
          ],
        ),
      ],
    );
  }

  Widget _metricTile(String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
