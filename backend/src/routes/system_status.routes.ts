import { Router } from 'express';
import { getSystemStatus } from '../controllers/system_status.controller';
import { authenticateJWT } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roleMiddleware';

const router = Router();

// ✅ Obtener estado del sistema (autenticado)
router.get('/status', authenticateJWT, getSystemStatus);

// Aquí puedes agregar más rutas si deseas control extendido del sistema (reinicio, métricas, etc.)

export default router;
