const express = require('express');
const { submitChallenge } = require('../controllers/challengeSubmission.controller');
const authMiddleware = require('../middlewares/auth.middleware');
const upload = require('../middlewares/upload.middleware');

const router = express.Router();

router.post(
  '/challenges/:id/submissions',
  authMiddleware,
  upload.single('file'),
  submitChallenge
);

module.exports = router;
