import '../../../core/services/api_service.dart';
import '../models/challenge.dart';
import '../models/challenge_submission_request.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ChallengeService {
  final ApiService _api = ApiService();

  Future<Challenge> getChallengeDetail(String id) async {
    final response = await _api.get('/challenges/$id');
    if (response.statusCode == 200) {
      return Challenge.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<void> submitChallengeParticipation(
    String challengeId, ChallengeSubmissionRequest data) async {
  final uri = Uri.parse('${_api.baseUrl}/challenges/$challengeId/submissions');

  final request = http.MultipartRequest('POST', uri)
    ..headers.addAll(await _api.headers)
    ..fields['comment'] = data.comment;

  if (data.file != null) {
    final file = await http.MultipartFile.fromPath(
      'file',
      data.file!.path,
      contentType: MediaType('application', 'octet-stream'), // Cambia si solo aceptas imágenes
    );
    request.files.add(file);
  }

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode != 200) {
    throw Exception('Error: ${response.body}');
  }
}
  
  Future<List<Challenge>> getAllChallenges() async {
    final response = await _api.get('/challenges');
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => Challenge.fromJson(item))
          .toList();
    } else {
      throw Exception('Error al obtener la lista de retos');
    }
  }
}
