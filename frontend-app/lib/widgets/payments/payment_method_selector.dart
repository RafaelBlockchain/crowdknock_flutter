import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final List<String> methods;
  final String selected;
  final ValueChanged<String> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.methods,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Método de pago", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: methods.map((method) {
            final isSelected = method == selected;
            return ChoiceChip(
              label: Text(method),
              selected: isSelected,
              onSelected: (_) => onChanged(method),
            );
          }).toList(),
        ),
      ],
    );
  }
}

