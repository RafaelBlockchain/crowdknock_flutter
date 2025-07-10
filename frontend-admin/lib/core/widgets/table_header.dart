import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final List<String> columns;
  final List<double>? columnWidths;
  final EdgeInsetsGeometry padding;

  const TableHeader({
    super.key,
    required this.columns,
    this.columnWidths,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: padding,
      child: Row(
        children: List.generate(columns.length, (index) {
          final width = columnWidths != null && index < columnWidths!.length
              ? columnWidths![index]
              : null;

          return Expanded(
            flex: width == null ? 1 : 0,
            child: SizedBox(
              width: width,
              child: Text(
                columns[index],
                style: theme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

