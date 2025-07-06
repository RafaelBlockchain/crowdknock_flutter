class Report {
  final String id;
  final String reportedBy;
  final String contentId;
  final String contentType;
  final String reason;
  final DateTime createdAt;
  final String status;

  Report({
    required this.id,
    required this.reportedBy,
    required this.contentId,
    required this.contentType,
    required this.reason,
    required this.createdAt,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'] ?? '',
      reportedBy: json['reportedBy'] ?? '',
      contentId: json['contentId'] ?? '',
      contentType: json['contentType'] ?? '',
      reason: json['reason'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reportedBy': reportedBy,
      'contentId': contentId,
      'contentType': contentType,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
