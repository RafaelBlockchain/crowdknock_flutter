const { Content } = require('../models');

async function getAllContent() {
  return await Content.findAll();
}

async function createContent(data) {
  return await Content.create(data);
}

async function updateContent(id, updates) {
  const content = await Content.findByPk(id);
  if (!content) throw new Error('Content not found');
  return await content.update(updates);
}

async function deleteContent(id) {
  const content = await Content.findByPk(id);
  if (!content) throw new Error('Content not found');
  await content.destroy();
}

module.exports = { getAllContent, createContent, updateContent, deleteContent };
