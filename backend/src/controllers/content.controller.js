// backend/src/controllers/content.controller.js
const ContentService = require('../services/ContentService');

const getAllContent = async (req, res, next) => {
  try {
    const contents = await ContentService.getAllContent();
    res.json(contents);
  } catch (err) {
    next(err);
  }
};

const createContent = async (req, res, next) => {
  try {
    const content = await ContentService.createContent(req.body);
    res.status(201).json(content);
  } catch (err) {
    next(err);
  }
};

const updateContent = async (req, res, next) => {
  try {
    const updated = await ContentService.updateContent(req.params.id, req.body);
    if (updated) res.json({ message: 'Content updated' });
    else res.status(404).json({ error: 'Not found' });
  } catch (err) {
    next(err);
  }
};

const deleteContent = async (req, res, next) => {
  try {
    await ContentService.deleteContent(req.params.id);
    res.json({ message: 'Content deleted' });
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

