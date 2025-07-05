// tests/payments.test.js
const request = require('supertest');
const app = require('../src/server');
const db = require('../src/config/db');

let token;
let paymentId;

beforeAll(async () => {
  await db.sync({ force: true });

  const res = await request(app).post('/api/auth/register').send({
    name: 'Payment User',
    email: 'pay@example.com',
    password: 'pay123',
    role: 'user'
  });

  token = res.body.token;
});

describe('Payments Endpoints', () => {
  it('POST /api/payments - should create a payment', async () => {
    const res = await request(app)
      .post('/api/payments')
      .set('Authorization', `Bearer ${token}`)
      .send({
        amount: 25.5,
        method: 'card',
        status: 'completed'
      });

    expect(res.statusCode).toBe(201);
    expect(res.body.amount).toBe(25.5);
    paymentId = res.body.id;
  });

  it('GET /api/payments - should list user payments', async () => {
    const res = await request(app)
      .get('/api/payments')
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('GET /api/payments/:id - should get specific payment', async () => {
    const res = await request(app)
      .get(`/api/payments/${paymentId}`)
      .set('Authorization', `Bearer ${token}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.id).toBe(paymentId);
  });
});
