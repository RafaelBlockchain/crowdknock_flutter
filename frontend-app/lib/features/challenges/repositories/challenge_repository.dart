import '../models/challenge.dart';
import '../services/challenge_service.dart';
import '../models/challenge_submission_request.dart';

class ChallengeRepository {
  final ChallengeService _service = ChallengeService();

  Future<Challenge> fetchChallenge(String id) {
    return _service.getChallengeDetail(id);
  }

  
  Future<void> submitParticipation(
    String challengeId, ChallengeSubmissionRequest submission) {
    return _service.submitChallengeParticipation(challengeId, submission);
  }

  Future<List<Challenge>> fetchAllChallenges() {
    return _service.getAllChallenges();
  }
}
