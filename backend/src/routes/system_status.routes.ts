import { Router } from 'express';
import { getSystemStatus } from '../controllers/system_status.controller';
import { authenticateJWT } from '../middlewares/auth.middleware';

const router = Router();

router.get('/status', authenticateJWT, getSystemStatus);

export default router;
