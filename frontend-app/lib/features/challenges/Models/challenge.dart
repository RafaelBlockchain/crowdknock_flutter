class Challenge {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        status: json['status'],
        createdAt: json['createdAt'],
      );
}
