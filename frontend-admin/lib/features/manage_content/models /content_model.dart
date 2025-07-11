class ContentModel {
  final String id;
  final String title;
  final String body;
  final String type;        // Ej: 'article', 'announcement', 'faq', etc.
  final String? imageUrl;
  final String author;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ContentModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.author,
    required this.createdAt,
    this.imageUrl,
    this.updatedAt,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      imageUrl: json['imageUrl'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'imageUrl': imageUrl,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
