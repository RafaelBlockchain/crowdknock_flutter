class PaymentModel {
  final String id;
  final String user;
  final double amount;
  final String date;
  final String status;

  PaymentModel({
    required this.id,
    required this.user,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        user: json['user'],
        amount: (json['amount'] as num).toDouble(),
        date: json['date'],
        status: json['status'],
      );
}

