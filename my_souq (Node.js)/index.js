const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const databaseConnect = 'mongodb+srv://abdallahelshayeb515:Abdallah21Elshayeb@cluster0.k93x7jm.mongodb.net/?retryWrites=true&w=majority';
const PORT = 3020;

const app = express();
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(databaseConnect).then(() => {
  console.log('connected :))');
}).catch(
  (err) => {
console.log(err);
  }
)

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server working at ${PORT}`);
});

