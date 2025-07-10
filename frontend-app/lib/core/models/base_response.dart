class BaseResponse<T> {
  final bool success;
  final T? data;
  final String? message;

  BaseResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'],
    );
  }
}

