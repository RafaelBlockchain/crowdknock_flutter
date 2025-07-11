class Report {
  final String id;
  final String user;         // Alias de 'reportedBy'
  final String contentId;
  final String contentType;  // Alias de 'type'
  final String reason;       // Alias de 'message'
  final DateTime createdAt;
  final String status;

  Report({
    required this.id,
    required this.user,
    required this.contentId,
    required this.contentType,
    required this.reason,
    required this.createdAt,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'] ?? json['id'] ?? '',
      user: json['reportedBy'] ?? json['user'] ?? '',
      contentId: json['contentId'] ?? '',
      contentType: json['contentType'] ?? json['type'] ?? '',
      reason: json['reason'] ?? json['message'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reportedBy': user,
      'contentId': contentId,
      'contentType': contentType,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
