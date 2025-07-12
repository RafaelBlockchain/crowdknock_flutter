import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/setting/widgets/settings_tile.dart';

void main() {
  testWidgets('SettingsTile muestra título y dispara onTap', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingsTile(
            icon: Icons.language,
            title: 'Idioma',
            subtitle: 'Español',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    // Verifica que el texto del título y subtítulo estén presentes
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Español'), findsOneWidget);

    // Simula tap
    await tester.tap(find.byType(SettingsTile));
    expect(tapped, true);
  });
}

