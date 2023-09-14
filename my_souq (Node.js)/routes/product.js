const express = require('express');
const productRouter = express.Router();
const auth = require('../components/my_auth');
const { Product } = require('../models/product');

productRouter.get('/api/get-products', auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

productRouter.get('/api/get-products/search/:txt', auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.txt, $options: 'i' },
    });
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
productRouter.post('/api/rate-product', auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId == req.user) {
        product.rating.splice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
    };
    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

productRouter.get('/api/deal-of-the-day', auth, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let sSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.rating.length; i++) {
        sSum += a.rating[i].rating;
      }
      for (let i = 0; i < b.rating.length; i++) {
        bSum += b.rating[i].rating;
      }
      return bSum - sSum;
    });
    res.json(products.slice(0, products.length));
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = productRouter;
