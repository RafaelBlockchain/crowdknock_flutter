// tests/reports.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;
let reportId;

beforeAll(async () => {
  await db.sync({ force: true });

  const user = await request(app).post('/api/auth/register').send({
    name: 'Reporter',
    email: 'report@example.com',
    password: 'report123',
    role: 'user'
  });

  token = user.body.token;
});

describe('Reports Endpoints', () => {
  it('POST /api/reports - should create a report', async () => {
    const res = await request(app)
      .post('/api/reports')
      .set('Authorization', `Bearer ${token}`)
      .send({
        contentId: 1,
        reason: 'inappropriate',
        details: 'Offensive content'
      });

    expect(res.statusCode).toBe(201);
    expect(res.body.reason).toBe('inappropriate');
    reportId = res.body.id;
  });

  it('GET /api/reports - should list reports (admin/moderator)', async () => {
    const res = await request(app)
      .get('/api/reports')
      .set('Authorization', `Bearer ${token}`); // Debe ser admin/moderador

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('PATCH /api/reports/:id/resolve - should resolve report', async () => {
    const res = await request(app)
      .patch(`/api/reports/${reportId}/resolve`)
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('resolved');
  });
});
