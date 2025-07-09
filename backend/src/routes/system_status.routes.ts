import { Router } from 'express';
import { getSystemStatus } from '../controllers/system_status.controller';
import { authenticateJWT } from '../middlewares/auth.middleware';

const router = Router();

// ✅ protección con middleware
router.get('/', authMiddleware, controller.handler);
router.post('/', authMiddleware, roleMiddleware(['admin']), controller.handler);

router.get('/status', authenticateJWT, getSystemStatus);

export default router;
