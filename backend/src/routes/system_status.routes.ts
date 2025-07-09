import { Router } from 'express';
import { getSystemStatus } from '../controllers/system_status.controller';
import { authenticateJWT } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roleMiddleware';

const router = Router();

// ✅ Obtener estado del sistema (solo admin autenticado)
router.get('/status', authenticateJWT, roleMiddleware(['admin']), getSystemStatus);

export default router;
