import 'package:flutter/material.dart';

class ActivityLogsPage extends StatelessWidget {
  const ActivityLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar
          const _Sidebar(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _PageTitle(),
                  SizedBox(height: 24),
                  _LogsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Activity Logs',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}

class _LogsSection extends StatelessWidget {
  const _LogsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _HeaderWithSearch(),
          const SizedBox(height: 24),
          _LogsTable(),
        ],
      ),
    );
  }
}

class _HeaderWithSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _LogsTable extends StatelessWidget {
  final List<List<dynamic>> logs = const [
    ['2025-06-28 12:34', 'admin@example.com', 'Logged in', '192.168.1.10', Colors.green],
    ['2025-06-28 12:38', 'editor@example.com', 'Edited story #102', '192.168.1.11', Colors.blue],
    ['2025-06-28 12:42', 'moderator@example.com', 'Deleted comment #245', '192.168.1.12', Colors.red],
  ];

  @override
  Widget build(BuildContext context) {
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

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final navItems = [
      ('Dashboard', false),
      ('Moderation', false),
      ('Analytics', false),
      ('Reports', false),
      ('Email Templates', false),
      ('Activity Logs', true),
      ('Settings', false),
    ];

    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 24),
          for (final item in navItems)
            _NavLink(label: item.$1, isActive: item.$2),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;

  const _NavLink({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
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
          // TODO: Integrar con GoRouter o sistema de navegación.
        },
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
