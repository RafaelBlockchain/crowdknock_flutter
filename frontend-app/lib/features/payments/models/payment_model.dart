class Payment {
  final String id;
  final String user;
  final double amount;
  final String status;
  final String date;

  Payment({
    required this.id,
    required this.user,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      user: json['user'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      date: json['date'],
    );
  }
}
