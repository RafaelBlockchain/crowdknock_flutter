// backend/src/controllers/user.controller.js
const UserService = require('../services/UserService');

const getAllUsers = async (req, res, next) => {
  try {
    const users = await UserService.getAllUsers();
    res.json(users);
  } catch (err) {
    next(err);
  }
};

const updateUser = async (req, res, next) => {
  try {
    const updated = await UserService.updateUser(req.params.id, req.body);
    if (updated) res.json({ message: 'User updated successfully' });
    else res.status(404).json({ error: 'User not found' });
  } catch (err) {
    next(err);
  }
};

const banUser = async (req, res, next) => {
  try {
    await UserService.banUser(req.params.id);
    res.json({ message: 'User banned successfully' });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAllUsers,
  updateUser,
  banUser,
};

