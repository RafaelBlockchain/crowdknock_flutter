import '../models/challenge.dart';
import '../services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _service = ChallengeService();

  Future<Challenge> fetchChallenge(String id) {
    return _service.getChallengeDetail(id);
  }
}