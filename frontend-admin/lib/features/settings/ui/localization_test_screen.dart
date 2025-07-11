import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/locale_provider.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';

class LocalizationTestScreen extends StatelessWidget {
  const LocalizationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(L.of(context).appTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<Locale>(
              value: currentLocale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  provider.setLocale(newLocale);
                }
              },
              items: LocaleProvider.L10n.all.map((locale) {
                final flag = LocaleProvider.L10n.getFlag(locale.languageCode);
                return DropdownMenuItem(
                  value: locale,
                  child: Text(flag),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("✅ ${L.of(context).language}: ${currentLocale.languageCode.toUpperCase()}"),
            const SizedBox(height: 20),
            Text("🧪 ${L.of(context).login}"),
            Text("🧪 ${L.of(context).register}"),
            Text("🧪 ${L.of(context).logout}"),
            Text("🧪 ${L.of(context).dashboard}"),
            Text("🧪 ${L.of(context).users}"),
            Text("🧪 ${L.of(context).content}"),
            Text("🧪 ${L.of(context).settings}"),
          ],
        ),
      ),
    );
  }
}
