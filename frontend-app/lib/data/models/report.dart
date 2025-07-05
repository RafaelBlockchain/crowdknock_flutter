class Report {
  final int id;
  final String userName;
  final String type;
  final DateTime createdAt;
  final String status;

  Report({
    required this.id,
    required this.userName,
    required this.type,
    required this.createdAt,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      userName: json['userName'] ?? 'Desconocido',
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }
}
