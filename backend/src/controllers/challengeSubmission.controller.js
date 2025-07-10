const submissionService = require('../services/challengeSubmission.service');

async function submitChallenge(req, res) {
  try {
    const userId = req.user.id; // del middleware JWT
    const challengeId = req.params.id;
    const comment = req.body.comment;
    const filePath = req.file ? req.file.path : null;

    const result = await submissionService.createSubmission({
      userId,
      challengeId,
      comment,
      filePath,
    });

    res.status(200).json({ message: 'Participación registrada', data: result });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al registrar participación' });
  }
}

module.exports = { submitChallenge };
