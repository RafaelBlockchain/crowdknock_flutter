import 'package:flutter/foundation.dart';
import '../../../core/services/api_service.dart';
import '../models/content_model.dart';

const db = require('../../config/db');

async function getAllContent() {
  const query = 'SELECT * FROM contents ORDER BY created_at DESC';
  const { rows } = await db.query(query);
  return rows;
}

async function getContentById(id) {
  const query = 'SELECT * FROM contents WHERE id = $1';
  const { rows } = await db.query(query, [id]);
  return rows[0];
}

module.exports = {
  getAllContent,
  getContentById,
};


class ContentService {
  final ApiService _api = ApiService();

  Future<List<ContentModel>> fetchAllContent() async {
    final response = await _api.get('/content');

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => ContentModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Error al obtener los contenidos');
    }
  }

  Future<ContentModel> fetchContentById(String id) async {
    final response = await _api.get('/content/$id');

    if (response.statusCode == 200) {
      return ContentModel.fromJson(response.data);
    } else {
      throw Exception('No se pudo cargar el contenido');
    }
  }
}
