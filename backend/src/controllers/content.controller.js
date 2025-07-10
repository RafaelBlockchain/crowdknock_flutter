const contentService = require('../services/content.service');
const { pick } = require('../utils/validation');

async function getAll(req, res) {
  try {
    const contents = await contentService.getAllContent();
    res.json(contents);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al obtener contenidos' });
  }
}

async function getById(req, res) {
  try {
    const content = await contentService.getContentById(req.params.id);
    if (!content) {
      return res.status(404).json({ message: 'Contenido no encontrado' });
    }
    res.json(content);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error al obtener contenido' });
  }
}

module.exports = {
  getAll,
  getById,
};


exports.getAllContent = async (req, res, next) => {
  try {
    const contents = await contentService.getAll();
    res.json({ success: true, data: contents });
  } catch (err) {
    next(err);
  }
};

exports.createContent = async (req, res, next) => {
  try {
    const allowedFields = ['title', 'type', 'url', 'description', 'status'];
    const data = pick(req.body, allowedFields);

    const content = await contentService.create(data);
    res.status(201).json({ success: true, data: content });
  } catch (err) {
    next(err);
  }
};

exports.updateContent = async (req, res, next) => {
  try {
    const allowedFields = ['title', 'type', 'url', 'description', 'status'];
    const data = pick(req.body, allowedFields);
    const { id } = req.params;

    const updated = await contentService.update(id, data);
    if (!updated) {
      return res.status(404).json({ success: false, error: 'Contenido no encontrado' });
    }

    res.json({ success: true, message: 'Contenido actualizado correctamente' });
  } catch (err) {
    next(err);
  }
};

exports.deleteContent = async (req, res, next) => {
  try {
    const deleted = await contentService.delete(req.params.id);
    if (!deleted) {
      return res.status(404).json({ success: false, error: 'Contenido no encontrado' });
    }

    res.json({ success: true, message: 'Contenido eliminado correctamente' });
  } catch (err) {
    next(err);
  }
};
