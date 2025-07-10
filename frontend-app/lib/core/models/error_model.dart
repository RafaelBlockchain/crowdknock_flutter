class ErrorModel {
  final String message;
  final int? statusCode;

  ErrorModel({
    required this.message,
    this.statusCode,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'] ?? 'Error desconocido',
      statusCode: json['statusCode'],
    );
  }
}

