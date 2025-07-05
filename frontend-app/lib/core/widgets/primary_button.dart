import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = !isDisabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null
            ? Icon(icon, size: 20)
            : const SizedBox.shrink(),
        label: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(label),
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          disabledBackgroundColor: Colors.grey.shade400,
        ),
      ),
    );
  }
}

