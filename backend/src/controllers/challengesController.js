const challengeService = require('../services/challenge.service');

exports.getAllChallenges = async (req, res) => {
  try {
    const challenges = await challengeService.getAll();
    res.json({ success: true, data: challenges });
  } catch (error) {
    console.error('Error al obtener desafíos:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.createChallenge = async (req, res) => {
  try {
    const newChallenge = await challengeService.create(req.body);
    res.status(201).json({ success: true, data: newChallenge });
  } catch (error) {
    console.error('Error al crear desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.updateChallenge = async (req, res) => {
  try {
    const { id } = req.params;
    const updated = await challengeService.update(id, req.body);

    if (!updated) {
      return res.status(404).json({ success: false, error: 'Desafío no encontrado' });
    }

    res.json({ success: true, message: 'Desafío actualizado correctamente' });
  } catch (error) {
    console.error('Error al actualizar desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};

exports.deleteChallenge = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await challengeService.delete(id);

    if (!deleted) {
      return res.status(404).json({ success: false, error: 'Desafío no encontrado' });
    }

    res.json({ success: true, message: 'Desafío eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar desafío:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
};
