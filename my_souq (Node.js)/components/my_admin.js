const jwt = require('jsonwebtoken');
const User = require('../models/user');

const admin = async (req , res, next) => {
  try {
    const token = req.header('souq-elshayeb-auth-token');
    if (!token) {
      return res.status(401).json({ msg: 'Not authorized user' });
    }

    const verifiedToken = jwt.verify(token, 'passwordKey');
    if (!verifiedToken) {
      return res.status(401).json({ msg: 'Token is not working, not allowed' });
    }
    const user = await User.findById(verifiedToken.id);
    if (user.type == 'user' || user.type == 'seller') {
      return res.status(401).json({ msg: 'this user is not admin' });
    }
    req.user = verifiedToken.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

module.exports = admin;