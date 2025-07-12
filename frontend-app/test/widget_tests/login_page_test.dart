import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/auth/login_page.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('Se renderizan campos de correo y contraseña', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(TextFormField, 'Correo electrónico'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Contraseña'), findsOneWidget);
    });

    testWidgets('Muestra error si los campos están vacíos', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Tap en botón de login sin escribir nada
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('El correo es obligatorio'), findsOneWidget);
      expect(find.text('La contraseña es obligatoria'), findsOneWidget);
    });

    testWidgets('Valida formato incorrecto de correo', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.enterText(find.widgetWithText(TextFormField, 'Correo electrónico'), 'invalido');
      await tester.enterText(find.widgetWithText(TextFormField, 'Contraseña'), '123456');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Correo inválido'), findsOneWidget);
    });

    testWidgets('Formulario válido dispara onSubmit (simulado)', (WidgetTester tester) async {
      bool loginInvocado = false;

      // Widget fake con LoginPage personalizada para test
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          return LoginPage(
            onLogin: () {
              loginInvocado = true;
            },
          );
        }),
      ));

      await tester.enterText(find.widgetWithText(TextFormField, 'Correo electrónico'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Contraseña'), '123456');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Simula que el botón disparó la acción
      expect(loginInvocado, true);
    });
  });
}

