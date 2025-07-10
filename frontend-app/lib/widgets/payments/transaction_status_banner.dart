import 'package:flutter/material.dart';

class TransactionStatusBanner extends StatelessWidget {
  final bool success;
  final String message;

  const TransactionStatusBanner({
    super.key,
    required this.success,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(success ? Icons.check_circle : Icons.error, color: success ? Colors.green : Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

