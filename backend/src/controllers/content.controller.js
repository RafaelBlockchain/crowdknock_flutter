const contentService = require('../services/content.service');
const { pick } = require('../utils/validation');

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
