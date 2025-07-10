import '../models/challenge_model.dart';
import '../../services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _service = ChallengeService();

  Future<List<ChallengeModel>> fetchAllChallenges() async {
    return await _service.getAllChallenges();
  }

  Future<ChallengeModel> getChallengeById(String id) async {
    return await _service.getById(id);
  }

  Future<void> submitChallenge({
    required String challengeId,
    required String comment,
    required String filePath,
  }) async {
    await _service.submitEvidence(
      challengeId: challengeId,
      comment: comment,
      filePath: filePath,
    );
  }
}

