const { User } = require('../models');

async function getAllUsers() {
  return await User.findAll();
}

async function getUserById(id) {
  return await User.findByPk(id);
}

async function updateUser(id, data) {
  const user = await User.findByPk(id);
  if (!user) throw new Error('User not found');
  return await user.update(data);
}

async function banUser(id) {
  const user = await User.findByPk(id);
  if (!user) throw new Error('User not found');
  return await user.update({ isBanned: true });
}

module.exports = { getAllUsers, getUserById, updateUser, banUser };
