// jest.config.js

module.exports = {
  globalSetup: './jest.global-setup.js',
  setupFilesAfterEnv: ['./jest.setup.js'],
  testEnvironment: 'node',
  testTimeout: 30000,
  verbose: true,
  testMatch: ['**/tests/**/*.test.js'], // Ubicación de los tests
  collectCoverage: true,
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/server.js',
    '!src/config/**',
    '!src/models/index.js',
    '!**/node_modules/**',
    '!**/tests/**'
  ],
  coverageReporters: ['text', 'lcov'],
};
