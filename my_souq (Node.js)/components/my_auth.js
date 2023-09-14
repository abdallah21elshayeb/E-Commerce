const jwt = require('jsonwebtoken');

const myAuth = async (req, res, next) => {
  try {
    const token = req.header('souq-elshayeb-auth-token');
    if (!token) {
      return res.status(401).json({ msg: 'Not authorized user' });
    }

    const verifiedToken = jwt.verify(token, 'passwordKey');
    if (!verifiedToken) {
      return res.status(401).json({ msg: 'Token is not working, not allowed' });
    }
    req.user = verifiedToken.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = myAuth;
