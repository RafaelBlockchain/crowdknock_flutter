import 'package:flutter/material.dart';

class AuditLogsPage extends StatelessWidget {
  const AuditLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
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
                _SidebarLink(title: 'Dashboard', route: '/dashboard'),
                _SidebarLink(title: 'Manage Users', route: '/manage-users'),
                _SidebarLink(title: 'Manage Content', route: '/manage-content'),
                _SidebarLink(title: 'Moderation', route: '/moderation'),
                _SidebarLink(title: 'Analytics', route: '/analytics'),
                _SidebarLink(title: 'Reports', route: '/reports'),
                _SidebarLink(title: 'Payments', route: '/payments'),
                _SidebarLink(title: 'Settings', route: '/settings'),
                _SidebarLink(
                  title: 'Audit Logs',
                  route: '/audit-logs',
                  isActive: true,
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Audit Logs',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Filter section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.black12)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Filter Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Wrap(
                          runSpacing: 12,
                          spacing: 12,
                          children: [
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search by user or action',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                items: const [
                                  DropdownMenuItem(value: 'All Actions', child: Text('All Actions')),
                                  DropdownMenuItem(value: 'User Login', child: Text('User Login')),
                                  DropdownMenuItem(value: 'Content Deleted', child: Text('Content Deleted')),
                                  DropdownMenuItem(value: 'Permission Updated', child: Text('Permission Updated')),
                                ],
                                onChanged: (_) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                                value: 'All Actions',
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Date',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              ),
                              child: const Text('Apply Filters'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Logs table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.black12)],
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((_) => Colors.grey[200]!),
                      columns: const [
                        DataColumn(label: Text('Timestamp')),
                        DataColumn(label: Text('User')),
                        DataColumn(label: Text('Action')),
                        DataColumn(label: Text('Details')),
                        DataColumn(label: Text('IP Address')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('2025-06-28 14:32')),
                          DataCell(Text('admin@crowdknock.com')),
                          DataCell(Text('User Login', style: TextStyle(color: Colors.indigo))),
                          DataCell(Text('Successful login')),
                          DataCell(Text('192.168.1.10')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2025-06-28 13:11')),
                          DataCell(Text('mod@crowdknock.com')),
                          DataCell(Text('Content Deleted', style: TextStyle(color: Colors.red))),
                          DataCell(Text('Removed offensive meme ID #43')),
                          DataCell(Text('192.168.1.23')),
                        ]),
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
}

class _SidebarLink extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarLink({
    required this.title,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navegación aquí si es necesario
      },
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: isActive ? Colors.indigo : Colors.transparent,
        foregroundColor: isActive ? Colors.white : Colors.black87,
      ),
      child: Text(title),
    );
  }
}

