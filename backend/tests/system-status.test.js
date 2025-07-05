// tests/system-status.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Sys Admin',
    email: 'sysadmin@example.com',
    password: 'adminpass',
    role: 'admin'
  });

  token = res.body.token;
});

describe('System Status Endpoint', () => {
  it('GET /api/status - should return system health', async () => {
    const res = await request(app)
      .get('/api/status')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('uptime');
    expect(res.body).toHaveProperty('status', 'ok');
  });
});
