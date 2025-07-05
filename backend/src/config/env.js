require('dotenv').config();

const requiredEnv = ['DATABASE_URL', 'JWT_SECRET', 'NODE_ENV'];

requiredEnv.forEach((key) => {
  if (!process.env[key]) {
    console.error(`❌ FALTA la variable de entorno: ${key}`);
    process.exit(1);
  }
});

const config = {
  databaseUrl: process.env.DATABASE_URL,
  jwtSecret: process.env.JWT_SECRET,
  nodeEnv: process.env.NODE_ENV || 'development',
  port: process.env.PORT || 4000,
};

module.exports = config;

