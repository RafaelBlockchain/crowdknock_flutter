import 'package:flutter/material.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';
import 'package:frontend_app/features/settings/widgets/language_picker.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        ...?actions,
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: LanguagePicker(), // 👈 Cambio de idioma desde AppBar
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
