import 'package:flutter/material.dart';
import '../models/challenge_model.dart';
import '../../services/challenge_service.dart';

class ChallengeProvider extends ChangeNotifier {
  List<ChallengeModel> _challenges = [];
  bool _isLoading = false;

  List<ChallengeModel> get challenges => _challenges;
  bool get isLoading => _isLoading;

  Future<void> loadChallenges() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ChallengeService().getAllChallenges();
      _challenges = data;
    } catch (e) {
      _challenges = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

