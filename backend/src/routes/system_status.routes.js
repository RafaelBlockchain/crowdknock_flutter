// src/routes/system_status.routes.js

const express = require('express');
const { fetchSystemStatus, modifySystemStatus } = require('../controllers/system_status.controller');
const { authenticateToken } = require('../middlewares/authMiddleware');
const { requireAdmin } = require('../middlewares/roleMiddleware');

const router = express.Router();

router.get('/', authenticateToken, requireAdmin, fetchSystemStatus);
router.put('/', authenticateToken, requireAdmin, modifySystemStatus);

module.exports = router;
