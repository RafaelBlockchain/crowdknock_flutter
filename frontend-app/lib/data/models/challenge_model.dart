class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String author;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.author,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'author': author,
  };
}

