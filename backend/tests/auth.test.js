const request = require('supertest');
const app = require('../src/app');
const db = require('../src/config/db');
const bcrypt = require('bcryptjs');

let token;
let testUser = {
  name: 'Test MeUser',
  email: 'meuser@example.com',
  password: 'Test1234',
};

beforeAll(async () => {
  // Limpia si ya existe
  await db.none('DELETE FROM users WHERE email = $1', [testUser.email]);

  // Crea usuario vía API
  const res = await request(app).post('/api/auth/register').send(testUser);
  token = res.body.token;
});

afterAll(async () => {
  await db.none('DELETE FROM users WHERE email = $1', [testUser.email]);
  await db.$pool.end(); // cerrar conexión a PostgreSQL
});

describe('Auth Endpoints', () => {
  it('POST /api/auth/login - should log in the user', async () => {
    const res = await request(app).post('/api/auth/login').send({
      email: testUser.email,
      password: testUser.password,
    });

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('token');
  });

  it('POST /api/auth/login - should fail on wrong credentials', async () => {
    const res = await request(app).post('/api/auth/login').send({
      email: testUser.email,
      password: 'wrongpassword',
    });

    expect(res.statusCode).toBe(401);
    expect(res.body.message || res.body.error).toBeDefined();
  });

  it('GET /api/auth/me - should return current user', async () => {
    const res = await request(app)
      .get('/api/auth/me')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty('user');
    expect(res.body.user.email).toBe(testUser.email);
  });

  it('GET /api/auth/me - should fail without token', async () => {
    const res = await request(app).get('/api/auth/me');
    expect(res.statusCode).toBe(401);
  });

  it('GET /api/auth/me - should fail with invalid token', async () => {
    const res = await request(app)
      .get('/api/auth/me')
      .set('Authorization', 'Bearer invalidtoken123');

    expect(res.statusCode).toBe(401);
  });
});
