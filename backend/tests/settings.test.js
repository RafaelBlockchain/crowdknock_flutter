// tests/settings.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Settings Admin',
    email: 'admin@settings.com',
    password: 'admin123',
    role: 'admin'
  });

  token = res.body.token;
});

describe('Settings Endpoints', () => {
  it('GET /api/settings - should return current settings', async () => {
    const res = await request(app)
      .get('/api/settings')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('maintenanceMode');
  });

  it('PATCH /api/settings - should update settings', async () => {
    const res = await request(app)
      .patch('/api/settings')
      .set('Authorization', `Bearer ${token}`)
      .send({
        maintenanceMode: true
      });

    expect(res.statusCode).toBe(200);
    expect(res.body.maintenanceMode).toBe(true);
  });
});
