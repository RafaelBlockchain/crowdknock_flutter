import '../models/challenge.dart';
import '../models/challenge_submission_request.dart';
import '../services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _service = ChallengeService();

  Future<Challenge> fetchChallenge(String id) {
    return _service.getChallengeDetail(id);
  }

  Future<List<Challenge>> fetchAllChallenges() {
    return _service.getAllChallenges();
  }

  Future<void> submitParticipation(String challengeId, ChallengeSubmissionRequest data) {
    return _service.submitChallengeParticipation(challengeId, data);
  }
}
