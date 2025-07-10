const path = require('path');
const fs = require('fs');

const submitChallengeParticipation = async (req, res) => {
  try {
    const challengeId = req.params.id;
    const comment = req.body.comment;
    const file = req.file;

    // Simula guardar en DB
    console.log("Challenge ID:", challengeId);
    console.log("Comentario:", comment);
    console.log("Archivo:", file ? file.filename : 'Sin archivo');

    return res.status(200).json({ message: "Participación registrada con éxito" });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Error al registrar la participación" });
  }
};

module.exports = {
  submitChallengeParticipation
};

