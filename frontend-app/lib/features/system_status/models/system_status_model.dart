class SystemStatus {
  final String apiStatus;
  final String dbStatus;
  final String version;
  final DateTime lastUpdated;

  SystemStatus({
    required this.apiStatus,
    required this.dbStatus,
    required this.version,
    required this.lastUpdated,
  });

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    return SystemStatus(
      apiStatus: json['apiStatus'] ?? 'desconocido',
      dbStatus: json['dbStatus'] ?? 'desconocido',
      version: json['version'] ?? 'N/A',
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
