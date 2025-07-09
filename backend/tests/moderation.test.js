const request = require('supertest');
const app = require('../src/app');
const db = require('../src/config/db');
const jwt = require('../src/utils/jwt');

let token;
let reportId;

beforeAll(async () => {
  await db.connect();

  // Simular token de moderador
  token = jwt.signToken({ id: 'mock-moderator-id', role: 'moderator' }, '1d');

  // Si necesitas obtener un reporte real desde la DB:
  const result = await db.query(`SELECT id FROM crowdknock.reports LIMIT 1`);
  reportId = result.rows[0]?.id;
});

afterAll(async () => {
  await db.end();
});

describe('🧪 Moderation Routes', () => {
  test('GET /api/moderation/reports - requiere auth', async () => {
    const res = await request(app).get('/api/moderation/reports');
    expect(res.statusCode).toBe(401);
  });

  test('GET /api/moderation/reports - con token válido', async () => {
    const res = await request(app)
      .get('/api/moderation/reports')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  test('PATCH /api/moderation/reports/:id/status - actualiza estado', async () => {
    if (!reportId) {
      return console.warn('⚠️ No hay reportes disponibles para test');
    }

    const res = await request(app)
      .patch(`/api/moderation/reports/${reportId}/status`)
      .send({ status: 'resolved' })
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.message).toMatch(/actualizado/i);
  });
});
