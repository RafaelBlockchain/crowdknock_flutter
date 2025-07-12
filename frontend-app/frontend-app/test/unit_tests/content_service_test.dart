import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/features/manage_content/models/content_model.dart';
import 'package:frontend_app/test/mocks/content_service_mock.dart';

void main() {
  late MockContentService contentService;

  setUp(() {
    contentService = MockContentService();
  });

  group('ContentService Tests (mock)', () {
    test('Obtener todos los contenidos', () async {
      final contents = await contentService.getAll();
      expect(contents.length, 2);
      expect(contents.first.title, 'Título 1');
    });

    test('Crear nuevo contenido', () async {
      final nuevo = ContentModel(
        id: '',
        title: 'Nuevo',
        description: 'Contenido creado desde test',
      );

      final creado = await contentService.create(nuevo);
      expect(creado.id, isNotEmpty);
      expect(creado.title, 'Nuevo');

      final all = await contentService.getAll();
      expect(all.length, 3);
    });

    test('Eliminar contenido existente', () async {
      final initial = await contentService.getAll();
      expect(initial.length, 2);

      await contentService.delete('1');
      final updated = await contentService.getAll();
      expect(updated.length, 1);
      expect(updated.any((c) => c.id == '1'), false);
    });
  });
}
