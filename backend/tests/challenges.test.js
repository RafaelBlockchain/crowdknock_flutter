// tests/challenges.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token, challengeId;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Challenge User',
    email: 'challenge@example.com',
    password: 'challenge123',
    role: 'user'
  });

  token = res.body.token;
});

describe('Challenges Endpoints', () => {
  it('POST /api/challenges - should create a challenge', async () => {
    const res = await request(app)
      .post('/api/challenges')
      .set('Authorization', `Bearer ${token}`)
      .send({
        title: 'First Challenge',
        description: 'Test challenge',
        startDate: new Date(),
        endDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
      });

    expect(res.statusCode).toBe(201);
    expect(res.body.title).toBe('First Challenge');
    challengeId = res.body.id;
  });

  it('GET /api/challenges - should list challenges', async () => {
    const res = await request(app)
      .get('/api/challenges')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('PATCH /api/challenges/:id - should update challenge', async () => {
    const res = await request(app)
      .patch(`/api/challenges/${challengeId}`)
      .set('Authorization', `Bearer ${token}`)
      .send({ description: 'Updated description' });

    expect(res.statusCode).toBe(200);
    expect(res.body.description).toBe('Updated description');
  });

  it('DELETE /api/challenges/:id - should delete challenge', async () => {
    const res = await request(app)
      .delete(`/api/challenges/${challengeId}`)
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(204);
  });
});
