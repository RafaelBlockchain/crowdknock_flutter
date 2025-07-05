import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/loading_indicator.dart';
import 'package:frontend_app/features/dashboard/data/dashboard_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<Map<String, dynamic>> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = DashboardRepository.fetchDashboardStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildStatCard('Usuarios', data['userCount'].toString()),
                _buildStatCard('Contenidos', data['contentCount'].toString()),
                _buildStatCard('Reportes', data['reportCount'].toString()),
                _buildStatCard('Retos', data['challengeCount'].toString()),
              ],
            ),
          );
        },
      ),
    );
  }

  {
  "userCount": 120,
  "contentCount": 58,
  "reportCount": 12,
  "challengeCount": 8
}


  
  Widget _buildStatCard(String label, String count) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(count, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
