// backend/src/controllers/content.controller.js
const ContentService = require('../services/ContentService');
const { pick } = require('../utils/validation'); // Utilidad para filtrar campos permitidos

// GET /content
const getAllContent = async (req, res, next) => {
  try {
    const contents = await ContentService.getAllContent();
    res.json({ success: true, data: contents });
  } catch (err) {
    next(err);
  }
};

// POST /content
const createContent = async (req, res, next) => {
  try {
    // Solo permitir campos válidos
    const allowedFields = ['title', 'type', 'url', 'description', 'status'];
    const data = pick(req.body, allowedFields);

    const content = await ContentService.createContent(data);
    res.status(201).json({ success: true, data: content });
  } catch (err) {
    next(err);
  }
};

// PUT /content/:id
const updateContent = async (req, res, next) => {
  try {
    const allowedFields = ['title', 'type', 'url', 'description', 'status'];
    const data = pick(req.body, allowedFields);

    const updated = await ContentService.updateContent(req.params.id, data);
    if (updated) {
      res.json({ success: true, message: 'Content updated' });
    } else {
      res.status(404).json({ success: false, error: 'Content not found' });
    }
  } catch (err) {
    next(err);
  }
};

// DELETE /content/:id
const deleteContent = async (req, res, next) => {
  try {
    const deleted = await ContentService.deleteContent(req.params.id);
    if (deleted) {
      res.json({ success: true, message: 'Content deleted' });
    } else {
      res.status(404).json({ success: false, error: 'Content not found' });
    }
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAllContent,
  createContent,
  updateContent,
  deleteContent,
};
