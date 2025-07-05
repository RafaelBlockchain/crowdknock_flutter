// tests/moderation.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;
let moderationId;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Moderator',
    email: 'mod@example.com',
    password: 'mod123',
    role: 'moderator'
  });

  token = res.body.token;
});

describe('Moderation Endpoints', () => {
  it('GET /api/moderation/reports - should list reports', async () => {
    const res = await request(app)
      .get('/api/moderation/reports')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('PATCH /api/moderation/reports/:id/resolve - should mark report resolved', async () => {
    const reportRes = await request(app)
      .post('/api/reports')
      .set('Authorization', `Bearer ${token}`)
      .send({
        contentId: 1,
        reason: 'spam',
        details: 'Spammy content'
      });

    moderationId = reportRes.body.id;

    const res = await request(app)
      .patch(`/api/moderation/reports/${moderationId}/resolve`)
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('resolved');
  });
});
