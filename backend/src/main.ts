import express from 'express';
import cors from 'cors';
import helmet from 'helmet';

import systemStatusRoutes from './routes/system_status.routes';
// Puedes importar aquí otras rutas si lo necesitas, por ejemplo:
// import authRoutes from './routes/auth.routes';

const app = express();

// Middlewares globales
app.use(helmet());
app.use(cors());
app.use(express.json());

// Rutas del sistema
app.use('/system', systemStatusRoutes);

// Puedes agregar más rutas aquí:
// app.use('/auth', authRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});

