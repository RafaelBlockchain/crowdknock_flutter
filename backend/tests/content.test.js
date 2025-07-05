// tests/content.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');
const { User } = require('../src/models');

let token;
let contentId;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Content Manager',
    email: 'content@example.com',
    password: 'content123',
    role: 'moderator'
  });

  token = res.body.token;
});

describe('Content Endpoints', () => {
  it('POST /api/content - should create content', async () => {
    const res = await request(app)
      .post('/api/content')
      .set('Authorization', `Bearer ${token}`)
      .send({
        title: 'Test Content',
        type: 'video',
        url: 'https://example.com/video.mp4'
      });

    expect(res.statusCode).toBe(201);
    expect(res.body.title).toBe('Test Content');
    contentId = res.body.id;
  });

  it('GET /api/content - should list all content', async () => {
    const res = await request(app)
      .get('/api/content')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('PUT /api/content/:id - should update content', async () => {
    const res = await request(app)
      .put(`/api/content/${contentId}`)
      .set('Authorization', `Bearer ${token}`)
      .send({ title: 'Updated Title' });

    expect(res.statusCode).toBe(200);
    expect(res.body.title).toBe('Updated Title');
  });

  it('DELETE /api/content/:id - should delete content', async () => {
    const res = await request(app)
      .delete(`/api/content/${contentId}`)
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(204);
  });
});
