class ContentModel {
  final String id;
  final String title;
  final String type;
  final String author;
  final String status;

  ContentModel({
    required this.id,
    required this.title,
    required this.type,
    required this.author,
    required this.status,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json['id'],
        title: json['title'],
        type: json['type'],
        author: json['author'],
        status: json['status'],
      );
}

