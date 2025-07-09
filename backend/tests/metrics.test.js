const request = require('supertest');
const app = require('../src/app'); // o '../src/server' si aplica
const db = require('../src/config/db');

let token;

beforeAll(async () => {
  await db.sync({ force: true }); // Limpia y resetea base de datos

  // Crear admin real desde la API
  const res = await request(app).post('/api/auth/register').send({
    name: 'Metrics Admin',
    email: 'metrics@example.com',
    password: 'metrics123',
    role: 'admin'
  });

  token = res.body.token;
});

afterAll(async () => {
  await db.close(); // Finaliza conexión
});

describe('📊 Metrics Endpoints', () => {
  test('GET /api/metrics/daily - sin token → 401', async () => {
    const res = await request(app).get('/api/metrics/daily');
    expect(res.statusCode).toBe(401);
  });

  test('GET /api/metrics/daily - con token admin', async () => {
    const res = await request(app)
      .get('/api/metrics/daily')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('GET /api/metrics/users - debe retornar métricas de usuarios', async () => {
    const res = await request(app)
      .get('/api/metrics/users')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalUsers');
  });

  test('GET /api/metrics/content - debe retornar métricas de contenido', async () => {
    const res = await request(app)
      .get('/api/metrics/content')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalContent');
  });

  test('GET /api/metrics/challenges - debe retornar métricas de desafíos', async () => {
    const res = await request(app)
      .get('/api/metrics/challenges')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalChallenges');
  });
});
