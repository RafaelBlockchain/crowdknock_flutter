const express = require('express');
const multer = require('multer');
const path = require('path');
const { submitChallengeParticipation } = require('../controllers/challengeSubmissionController');

const router = express.Router();

// Configuración de almacenamiento con Multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const filename = Date.now() + '-' + Math.round(Math.random() * 1E9) + ext;
    cb(null, filename);
  }
});

const upload = multer({ storage });

router.post(
  '/challenges/:id/submissions',
  upload.single('file'), // campo que viene de Flutter
  submitChallengeParticipation
);

module.exports = router;

