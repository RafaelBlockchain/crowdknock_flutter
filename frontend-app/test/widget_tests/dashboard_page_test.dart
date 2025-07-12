import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/dashboard/dashboard_page.dart';

void main() {
  group('DashboardPage Widget Tests', () {
    testWidgets('Se renderiza el AppBar con título correcto', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget); // Asegúrate que tu AppBar tenga ese título
    });

    testWidgets('Se renderiza contenido principal (ListView, Card o similar)', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      // Busca un ListView o GridView, dependiendo del diseño
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('Contiene al menos un botón funcional', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);

      // Simula tap en el primer botón
      await tester.tap(buttons.first);
      await tester.pump();

      // Puedes verificar si algo cambia tras el tap si lo defines
    });

    testWidgets('Dashboard muestra métricas o textos clave', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      expect(find.textContaining('Total'), findsWidgets);     // Ej: Total de casos
      expect(find.textContaining('Usuarios'), findsWidgets);  // Ej: Usuarios activos
    });
  });
}

