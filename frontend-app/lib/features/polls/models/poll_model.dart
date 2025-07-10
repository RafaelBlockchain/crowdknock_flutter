class PollOption {
  final String id;
  final String text;
  final int votes;

  PollOption({required this.id, required this.text, required this.votes});

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      text: json['text'],
      votes: json['votes'] ?? 0,
    );
  }
}

class PollModel {
  final String id;
  final String question;
  final List<PollOption> options;
  final bool isClosed;
  final DateTime createdAt;

  PollModel({
    required this.id,
    required this.question,
    required this.options,
    required this.isClosed,
    required this.createdAt,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'],
      question: json['question'],
      isClosed: json['isClosed'],
      createdAt: DateTime.parse(json['createdAt']),
      options: (json['options'] as List)
          .map((opt) => PollOption.fromJson(opt))
          .toList(),
    );
  }
}

