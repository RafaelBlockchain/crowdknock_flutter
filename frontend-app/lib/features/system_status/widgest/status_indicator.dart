import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String label;
  final bool isOnline;

  const StatusIndicator({super.key, required this.label, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isOnline ? Icons.check_circle : Icons.cancel,
          color: isOnline ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 12),
        Text(
          "$label: ${isOnline ? 'Activo' : 'Inactivo'}",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

