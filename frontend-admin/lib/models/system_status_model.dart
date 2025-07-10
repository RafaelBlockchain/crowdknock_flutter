class SystemHealth {
  final String status;
  final String uptime;
  final String version;

  SystemHealth({
    required this.status,
    required this.uptime,
    required this.version,
  });

  factory SystemHealth.fromJson(Map<String, dynamic> json) => SystemHealth(
        status: json['status'],
        uptime: json['uptime'],
        version: json['version'],
      );
}

class ServiceStatus {
  final String name;
  final String status;
  final String? details;

  ServiceStatus({
    required this.name,
    required this.status,
    this.details,
  });

  factory ServiceStatus.fromJson(Map<String, dynamic> json) => ServiceStatus(
        name: json['name'],
        status: json['status'],
        details: json['details'],
      );
}

class ServerMetrics {
  final double cpu;
  final String memory;
  final String disk;
  final int connections;

  ServerMetrics({
    required this.cpu,
    required this.memory,
    required this.disk,
    required this.connections,
  });

  factory ServerMetrics.fromJson(Map<String, dynamic> json) => ServerMetrics(
        cpu: (json['cpu'] as num).toDouble(),
        memory: json['memory'],
        disk: json['disk'],
        connections: json['connections'],
      );
}

