import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/locale_provider.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale;

    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          provider.setLocale(newLocale);
        }
      },
      items: L10n.all.map((locale) {
        final flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          value: locale,
          child: Text(flag),
        );
      }).toList(),
    );
  }
}
