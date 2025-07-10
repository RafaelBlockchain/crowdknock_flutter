class PollOption {
  final String id;
  final String text;
  final int votes;

  PollOption({
    required this.id,
    required this.text,
    required this.votes,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      text: json['text'],
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'votes': votes,
  };
}

class PollModel {
  final String id;
  final String question;
  final List<PollOption> options;
  final String author;
  final DateTime createdAt;
  final DateTime? expiresAt;

  PollModel({
    required this.id,
    required this.question,
    required this.options,
    required this.author,
    required this.createdAt,
    this.expiresAt,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'],
      question: json['question'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      options: (json['options'] as List<dynamic>)
          .map((e) => PollOption.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'author': author,
    'createdAt': createdAt.toIso8601String(),
    'expiresAt': expiresAt?.toIso8601String(),
    'options': options.map((e) => e.toJson()).toList(),
  };
}

