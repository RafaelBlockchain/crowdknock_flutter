import '../models/poll_model.dart';
import '../../services/poll_service.dart';

class PollRepository {
  final PollService _service = PollService();

  /// Obtener todas las encuestas disponibles
  Future<List<PollModel>> fetchAllPolls() async {
    return await _service.getAll();
  }

  /// Obtener una encuesta específica por su ID
  Future<PollModel> fetchPollById(String pollId) async {
    return await _service.getById(pollId);
  }

  /// Enviar un voto a una opción específica de una encuesta
  Future<PollModel> vote({
    required String pollId,
    required String optionId,
  }) async {
    return await _service.vote(pollId: pollId, optionId: optionId);
  }

  /// Crear una nueva encuesta
  Future<PollModel> createPoll(PollModel poll) async {
    return await _service.create(poll);
  }

  /// Cerrar una encuesta
  Future<void> closePoll(String pollId) async {
    return await _service.closePoll(pollId);
  }
}

