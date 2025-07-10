import '../../../core/services/api_service.dart';
import '../models/poll_model.dart';

class PollService {
  final ApiService _api = ApiService();

  Future<List<PollModel>> fetchPolls() async {
    final response = await _api.get('/polls');
    return (response.data as List)
        .map((item) => PollModel.fromJson(item))
        .toList();
  }

  Future<PollModel> fetchPollById(String id) async {
    final response = await _api.get('/polls/$id');
    return PollModel.fromJson(response.data);
  }

  Future<void> vote(String pollId, String optionId) async {
    await _api.post('/polls/$pollId/vote', data: {'optionId': optionId});
  }
}

