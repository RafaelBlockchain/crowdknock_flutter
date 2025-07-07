class SystemStatus {
  final String apiStatus;
  final String dbStatus;
  final String version;
  final DateTime lastUpdated;
  final double serverUptime;
  final int activeUsers;
  final List<double> systemLoad;
  final int memoryUsage;
  final String lastDowntime;

  SystemStatus({
    required this.apiStatus,
    required this.dbStatus,
    required this.version,
    required this.lastUpdated,
    required this.serverUptime,
    required this.activeUsers,
    required this.systemLoad,
    required this.memoryUsage,
    required this.lastDowntime,
  });

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    return SystemStatus(
      serverUptime: json['serverUptime']?.toDouble() ?? 0.0,
      activeUsers: json['activeUsers'] ?? 0,
      systemLoad: List<double>.from(json['systemLoad'].map((e) => (e as num).toDouble())),
      memoryUsage: json['memoryUsage'] ?? 0,
      lastDowntime: json['lastDowntime'] ?? '',
      apiStatus: json['apiStatus'] ?? 'desconocido',
      dbStatus: json['dbStatus'] ?? 'desconocido',
      version: json['version'] ?? 'N/A',
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
