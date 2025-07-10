import 'dart:io';

class ChallengeSubmissionRequest {
  final String comment;
  final File? file;

  ChallengeSubmissionRequest({
    required this.comment,
    this.file,
  });

  Map<String, String> toJson() => {
    'comment': comment,
  };
}
