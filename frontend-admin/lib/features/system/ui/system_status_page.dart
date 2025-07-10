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
    _fetchStatus();
  }

  Future<void> _fetchStatus() async {
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
      debugPrint('❌ Error al cargar estado del sistema: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📡 Estado del Sistema',
      currentRoute: '/system-status',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchStatus,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSystemHealthCard(),
                    const SizedBox(height: 24),
                    _buildServiceStatusTable(),
                    const SizedBox(height: 24),
                    _buildServerMetricsGrid(),
                  ],
                ),
              ),
            ),
    );
  }

  /// 🟢 Estado General
  Widget _buildSystemHealthCard() {
    if (systemHealth == null) return const SizedBox();

    final isOk = systemHealth!['status'] == 'ok';
    final color = isOk ? Colors.green : Colors.red;

    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(isOk ? Icons.check_circle : Icons.warning_amber_rounded, color: color, size: 32),
        title: Text('Estado General: ${systemHealth!['status'].toString().toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Uptime: ${systemHealth!['uptime']}  •  Versión: ${systemHealth!['version']}'),
      ),
    );
  }

  /// 🔧 Tabla de Servicios Internos
  Widget _buildServiceStatusTable() {
    if (serviceStatuses.isEmpty) {
      return const Text('⚠️ No se encontraron servicios internos.');
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Servicios Internos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
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
                        Icon(isUp ? Icons.check_circle : Icons.cancel,
                            color: isUp ? Colors.green : Colors.red, size: 18),
                        const SizedBox(width: 6),
                        Text(service['status'].toUpperCase(),
                            style: TextStyle(
                                color: isUp ? Colors.green[800] : Colors.red[800],
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
                    DataCell(Text(service['details'] ?? '-', style: const TextStyle(fontSize: 13))),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📈 Métricas del Servidor
  Widget _buildServerMetricsGrid() {
    if (serverMetrics == null) return const SizedBox();

    final tiles = [
      _metricTile('CPU (%)', '${serverMetrics!['cpu']}%'),
      _metricTile('Memoria', serverMetrics!['memory'] ?? '--'),
      _metricTile('Conexiones', '${serverMetrics!['connections']}'),
      _metricTile('Uso de Disco', serverMetrics!['disk'] ?? '--'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Métricas del Servidor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: tiles,
        ),
      ],
    );
  }

  Widget _metricTile(String label, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

