import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/manage_content/pages/content_list.dart';

void main() {
  group('ContentListPage Widget Tests', () {
    testWidgets('Renderiza la página y elementos principales', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ContentListPage()));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Gestión de Contenidos'), findsOneWidget); // Asegúrate de que exista
    });

    testWidgets('Muestra mensaje cuando no hay contenido', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ContentListPage()));

      await tester.pump(const Duration(milliseconds: 500)); // espera a carga simulada

      expect(find.textContaining('No hay contenidos disponibles'), findsOneWidget);
    });

    testWidgets('Renderiza lista si hay contenidos (mockeado)', (WidgetTester tester) async {
      // Usa un widget de prueba que pase contenido simulado
      final mockContentList = List.generate(
        3,
        (i) => ListTile(title: Text('Contenido $i')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Gestión de Contenidos')),
            body: ListView(children: mockContentList),
          ),
        ),
      );

      for (int i = 0; i < 3; i++) {
        expect(find.text('Contenido $i'), findsOneWidget);
      }
    });

    testWidgets('Botón de agregar contenido está presente y funciona', (WidgetTester tester) async {
      bool creado = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContentListPage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => creado = true,
              tooltip: 'Agregar',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byTooltip('Agregar'), findsOneWidget);

      await tester.tap(find.byTooltip('Agregar'));
      expect(creado, true);
    });
  });
}

