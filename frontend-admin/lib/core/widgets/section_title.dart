import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final Color color;

  const SectionTitle({
    super.key,
    required this.title,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: color),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}

