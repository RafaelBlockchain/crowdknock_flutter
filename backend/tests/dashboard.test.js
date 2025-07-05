// tests/dashboard.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Admin Dashboard',
    email: 'admin@dash.com',
    password: 'admin123',
    role: 'admin'
  });

  token = res.body.token;
});

describe('Dashboard Metrics Endpoints', () => {
  it('GET /api/metrics - should return dashboard summary', async () => {
    const res = await request(app)
      .get('/api/metrics')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalUsers');
    expect(res.body).toHaveProperty('totalReports');
    expect(res.body).toHaveProperty('totalContent');
  });
});
