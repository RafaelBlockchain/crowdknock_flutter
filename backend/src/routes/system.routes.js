import express from 'express';
import { getSystemStatus } from '../controllers/system.controller.js';
import { authenticateToken } from '../middlewares/authMiddleware.js';
import { authorizeRoles } from '../middlewares/roleMiddleware.js';

const router = express.Router();

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

router.get('/status', authenticateToken, authorizeRoles('admin'), getSystemStatus);

export default router;
