const express = require('express');
const router = express.Router();
const db = require('../db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Register
router.post('/register', async (req, res) => {
  const { full_name, email, phone, password } = req.body;
  try {
    const [userExists] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (userExists.length > 0) return res.status(409).json({ message: 'Email already exists' });

    const hash = await bcrypt.hash(password, 10);
    await db.query('INSERT INTO users (full_name, email, phone, password_hash) VALUES (?, ?, ?, ?)', 
      [full_name, email, phone, hash]);
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err });
  }
});

// Login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const [user] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (user.length === 0) return res.status(404).json({ message: 'User not found' });

    const valid = await bcrypt.compare(password, user[0].password_hash);
    if (!valid) return res.status(401).json({ message: 'Invalid password' });

    const token = jwt.sign({ user_id: user[0].user_id }, process.env.JWT_SECRET, { expiresIn: '7d' });
    res.json({ message: 'Login successful', token });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err });
  }
});

module.exports = router;
