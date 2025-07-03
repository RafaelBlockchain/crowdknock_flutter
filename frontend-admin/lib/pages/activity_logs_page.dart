import 'package:flutter/material.dart';

class ActivityLogsPage extends StatelessWidget {
  const ActivityLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar Navigation
          _buildSidebar(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activity Logs',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Logs Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Header with Search
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'System Activity',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 240,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search logs...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildLogsTable(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          _navLink('Email Templates', false),
          _navLink('Activity Logs', true),
          _navLink('Settings', false),
        ],
      ),
    );
  }

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
          // Aquí puedes agregar la lógica de navegación según el sistema de rutas que uses.
        },
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildLogsTable() {
    final logs = [
      ['2025-06-28 12:34', 'admin@example.com', 'Logged in', '192.168.1.10', Colors.green],
      ['2025-06-28 12:38', 'editor@example.com', 'Edited story #102', '192.168.1.11', Colors.blue],
      ['2025-06-28 12:42', 'moderator@example.com', 'Deleted comment #245', '192.168.1.12', Colors.red],
    ];

    return DataTable(
      columns: const [
        DataColumn(label: Text('Timestamp')),
        DataColumn(label: Text('User')),
        DataColumn(label: Text('Action')),
        DataColumn(label: Text('IP Address')),
      ],
      rows: logs.map((log) {
        return DataRow(
          cells: [
            DataCell(Text(log[0] as String)),
            DataCell(Text(log[1] as String)),
            DataCell(Text(
              log[2] as String,
              style: TextStyle(color: log[4] as Color),
            )),
            DataCell(Text(log[3] as String)),
          ],
        );
      }).toList(),
    );
  }
}
