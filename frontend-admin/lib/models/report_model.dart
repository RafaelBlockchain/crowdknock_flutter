class ReportModel {
  final String id;
  final String user;
  final String type;
  final String message;
  final String date;

  ReportModel({
    required this.id,
    required this.user,
    required this.type,
    required this.message,
    required this.date,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json['id'],
        user: json['user'],
        type: json['type'],
        message: json['message'],
        date: json['date'],
      );
}

