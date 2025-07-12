
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/dashboard/dashboard_page.dart';

void main() {
  group('DashboardPage Widget Tests', () {
    testWidgets('Renderiza AppBar con título "Dashboard"', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Renderiza lista de tarjetas o contenido', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DashboardPage()),
      );

      // Busca si hay un ListView, GridView o equivalente
      final listViewFinder = find.byType(ListView);
      final cardFinder = find.byType(Card);

      expect(listViewFinder, findsOneWidget); // Cambia según estructura
      expect(cardFinder, findsWidgets); // Asegúrate de usar Cards o containers identificables
    });

    testWidgets('Botón funcional está presente y responde al tap', (WidgetTester tester) async {
      bool accionEjecutada = false;

      // Widget de prueba con acción simulada
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardPage(onActionPressed: () {
              accionEjecutada = true;
            }),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsWidgets);

      await tester.tap(buttonFinder.first);
      await tester.pump();

      expect(accionEjecutada, true);
    });

    testWidgets('Muestra métricas clave como "Total", "Usuarios", etc.', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      expect(find.textContaining('Total'), findsWidgets); // Ej: "Total de casos"
      expect(find.textContaining('Usuarios'), findsWidgets); // Ej: "Usuarios activos"
    });
  });
}
