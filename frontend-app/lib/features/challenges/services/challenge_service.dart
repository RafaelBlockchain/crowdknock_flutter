import '../../../core/services/api_service.dart';
import '../models/challenge.dart';

class ChallengeService {
  final ApiService _api = ApiService();

  Future<Challenge> getChallengeDetail(String id) async {
    final response = await _api.get('/challenges/\$id');
    if (response.statusCode == 200) {
      return Challenge.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }
}