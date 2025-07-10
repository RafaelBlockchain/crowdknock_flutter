class ModerationItem {
  final String id;
  final String content;
  final String reason;
  final String type; // video, comment, etc.

  ModerationItem({
    required this.id,
    required this.content,
    required this.reason,
    required this.type,
  });

  factory ModerationItem.fromJson(Map<String, dynamic> json) => ModerationItem(
        id: json['id'],
        content: json['content'],
        reason: json['reason'],
        type: json['type'],
      );
}

