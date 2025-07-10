class ReportModel {
  final String id;
  final String reportType; // Ej: 'contenido', 'usuario', 'sistema'
  final String reportedItemId;
  final String reason;
  final String? details;
  final String reporterId;
  final DateTime createdAt;
  final String status; // Ej: 'pendiente', 'resuelto', 'rechazado'

  ReportModel({
    required this.id,
    required this.reportType,
    required this.reportedItemId,
    required this.reason,
    this.details,
    required this.reporterId,
    required this.createdAt,
    required this.status,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      reportType: json['reportType'],
      reportedItemId: json['reportedItemId'],
      reason: json['reason'],
      details: json['details'],
      reporterId: json['reporterId'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'reportType': reportType,
    'reportedItemId': reportedItemId,
    'reason': reason,
    'details': details,
    'reporterId': reporterId,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
  };
}

