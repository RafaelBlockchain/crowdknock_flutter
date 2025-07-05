// tests/auth.test.js
const request = require('supertest');
const app = require('../src/server'); // Asegúrate de exportar app desde server.js
const db = require('../src/config/db');

beforeAll(async () => {
  await db.sync({ force: true }); // Limpia la DB de prueba
});

describe('Auth Endpoints', () => {
  test('POST /api/auth/register - should create new user', async () => {
    const res = await request(app).post('/api/auth/register').send({
      name: 'Test User',
      email: 'test@example.com',
      password: '123456'
    });

    expect(res.statusCode).toEqual(201);
    expect(res.body.token).toBeDefined();
  });

  test('POST /api/auth/login - should return token', async () => {
    const res = await request(app).post('/api/auth/login').send({
      email: 'test@example.com',
      password: '123456'
    });

    expect(res.statusCode).toEqual(200);
    expect(res.body.token).toBeDefined();
  });
});
