import 'package:frontend_app/features/manage_content/models/content_model.dart';

class MockContentService {
  List<ContentModel> mockContents = [
    ContentModel(id: '1', title: 'Título 1', description: 'Desc 1'),
    ContentModel(id: '2', title: 'Título 2', description: 'Desc 2'),
  ];

  Future<List<ContentModel>> getAll() async {
    await Future.delayed(Duration(milliseconds: 300)); // Simula API delay
    return mockContents;
  }

  Future<ContentModel> create(ContentModel content) async {
    final newContent = content.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
    mockContents.add(newContent);
    return newContent;
  }

  Future<void> delete(String id) async {
    mockContents.removeWhere((c) => c.id == id);
  }
}
