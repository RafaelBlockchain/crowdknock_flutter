import 'package:flutter/material.dart';
import '../models/poll_model.dart';
import '../../services/poll_service.dart';

class PollProvider extends ChangeNotifier {
  final List<PollModel> _polls = [];
  bool _isLoading = false;
  String? _error;

  List<PollModel> get polls => _polls;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carga las encuestas desde el backend
  Future<void> loadPolls() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await PollService().getAll();
      _polls
        ..clear()
        ..addAll(data);
    } catch (e) {
      _error = 'Error al cargar encuestas';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Enviar voto a una opción de una encuesta
  Future<void> vote(String pollId, String optionId) async {
    try {
      final updatedPoll = await PollService().vote(pollId, optionId);
      final index = _polls.indexWhere((p) => p.id == pollId);
      if (index != -1) {
        _polls[index] = updatedPoll;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error al enviar voto';
      notifyListeners();
    }
  }

  /// Obtener encuesta específica
  PollModel? getPollById(String id) {
    try {
      return _polls.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

