class MetricModel {
  final String id;
  final String name;
  final int value;
  final String unit;
  final DateTime timestamp;

  MetricModel({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
    required this.timestamp,
  });

  factory MetricModel.fromJson(Map<String, dynamic> json) {
    return MetricModel(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      unit: json['unit'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'value': value,
    'unit': unit,
    'timestamp': timestamp.toIso8601String(),
  };
}

