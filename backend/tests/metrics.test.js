// tests/metrics.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Metrics Admin',
    email: 'metrics@example.com',
    password: 'metrics123',
    role: 'admin'
  });

  token = res.body.token;
});

describe('Metrics Endpoints', () => {
  it('GET /api/metrics/users - should return user metrics', async () => {
    const res = await request(app)
      .get('/api/metrics/users')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalUsers');
  });

  it('GET /api/metrics/content - should return content stats', async () => {
    const res = await request(app)
      .get('/api/metrics/content')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalContent');
  });

  it('GET /api/metrics/challenges - should return challenge stats', async () => {
    const res = await request(app)
      .get('/api/metrics/challenges')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('totalChallenges');
  });
});
