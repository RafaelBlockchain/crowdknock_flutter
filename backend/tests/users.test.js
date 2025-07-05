// tests/users.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');
const { User } = require('../src/models');

let adminToken;

beforeAll(async () => {
  await db.sync({ force: true });

  // Crear usuario admin para pruebas
  const res = await request(app).post('/api/auth/register').send({
    name: 'Admin User',
    email: 'admin@example.com',
    password: 'admin123',
    role: 'admin'
  });

  adminToken = res.body.token;
});

describe('Users Endpoints', () => {
  it('GET /api/users - should return list of users', async () => {
    const res = await request(app)
      .get('/api/users')
      .set('Authorization', `Bearer ${adminToken}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('PUT /api/users/:id - should update a user', async () => {
    const user = await User.findOne({ where: { email: 'admin@example.com' } });

    const res = await request(app)
      .put(`/api/users/${user.id}`)
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ name: 'Updated Admin' });

    expect(res.statusCode).toBe(200);
    expect(res.body.name).toBe('Updated Admin');
  });

  it('PATCH /api/users/:id/ban - should ban a user', async () => {
    const user = await User.findOne({ where: { email: 'admin@example.com' } });

    const res = await request(app)
      .patch(`/api/users/${user.id}/ban`)
      .set('Authorization', `Bearer ${adminToken}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.banned).toBe(true);
  });
});
