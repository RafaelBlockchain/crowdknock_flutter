class SystemStatusModel {
  final bool apiOnline;
  final DateTime lastCheck;
  final int activeUsers;
  final int pendingReports;
  final int totalChallenges;
  final int totalContentItems;

  SystemStatusModel({
    required this.apiOnline,
    required this.lastCheck,
    required this.activeUsers,
    required this.pendingReports,
    required this.totalChallenges,
    required this.totalContentItems,
  });

  factory SystemStatusModel.fromJson(Map<String, dynamic> json) {
    return SystemStatusModel(
      apiOnline: json['apiOnline'] ?? false,
      lastCheck: DateTime.parse(json['lastCheck']),
      activeUsers: json['activeUsers'] ?? 0,
      pendingReports: json['pendingReports'] ?? 0,
      totalChallenges: json['totalChallenges'] ?? 0,
      totalContentItems: json['totalContentItems'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'apiOnline': apiOnline,
    'lastCheck': lastCheck.toIso8601String(),
    'activeUsers': activeUsers,
    'pendingReports': pendingReports,
    'totalChallenges': totalChallenges,
    'totalContentItems': totalContentItems,
  };
}

