// backend/tests/auth.test.js
const request = require('supertest');
const app = require('../src/server'); // exporta tu app desde server.js
const db = require('../src/config/db');

describe('Auth Endpoints', () => {
  beforeAll(async () => {
    await db.connect();
  });

  afterAll(async () => {
    await db.end();
  });

  it('debe registrar un nuevo usuario', async () => {
    const res = await request(app)
      .post('/api/auth/register')
      .send({
        name: 'Test User',
        email: 'test@example.com',
        password: '123456',
        role: 'admin'
      });
    expect(res.statusCode).toEqual(201);
    expect(res.body).toHaveProperty('token');
  });

  it('debe loguearse con usuario existente', async () => {
    const res = await request(app)
      .post('/api/auth/login')
      .send({
        email: 'test@example.com',
        password: '123456'
      });
    expect(res.statusCode).toEqual(200);
    expect(res.body).toHaveProperty('token');
  });
});
