const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const myAuth = require('../components/my_auth');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: 'Email is already there' });
    }

    const hashPassword = await bcrypt.hash(password, 8);

    let user = new User({ email, password: hashPassword, name });

    user = await user.save();
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: 'User is not exist !' });
    }

    const isMatchPassword = await bcrypt.compare(password, user.password);

    if (!isMatchPassword) {
      return res.status(400).json({ msg: 'password is not correct !' });
    }

    const token = jwt.sign({ id: user._id }, 'passwordKey');
    res.json({ token, ...user._doc });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post('/isValidToken', async (req, res) => {
  try {
    const token = req.header('souq-elshayeb-auth-token');

    if (!token) return res.json(false);

    const verifiedToken = jwt.verify(token, 'passwordKey');

    if (!verifiedToken) {
      return res.json(false);
    } else {
      const user = await User.findById(verifiedToken.id);

      if (!user) {
        return res.json(false);
      } else {
        return res.json(true);
      }
    }
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.get('/', myAuth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
