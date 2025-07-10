import '../../../core/services/api_service.dart';
import '../models/challenge.dart';

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
