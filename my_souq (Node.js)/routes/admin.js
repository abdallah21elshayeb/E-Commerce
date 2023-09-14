const express = require('express');
const { Product } = require('../models/product');
const admin = require('../components/my_admin');
const Order = require('../models/order');

const adminRouter = express.Router();

adminRouter.post('/admin/add-product', admin, async (req, res) => {
  try {
    const { name, description, images, price, quantity, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      price,
      quantity,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.post('/admin/delete-product', admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    // product = await product.save();
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.get('/api/all-orders-admin', admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.post('/admin/update-order-status', admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.get('/admin/analytics', admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalSales = 0;
    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalSales +=
          orders[i].products[j].product.price * orders[i].products[j].quantity;
      }
    }
    const totalOrders = orders.length;
    const totalProducts = await Product.find({}).countDocuments();

    let catMobiles = await getCategoryTotalSale('Mobiles');
    let catAppliances = await getCategoryTotalSale('Appliances');
    let catFashion = await getCategoryTotalSale('Fashion');
    let catEssentials = await getCategoryTotalSale('Essentials');
    let catComputers = await getCategoryTotalSale('Computers');

    let totals = {
      totalSales,
      totalOrders,
      totalProducts,
      catMobiles,
      catAppliances,
      catFashion,
      catEssentials,
      catComputers,
    };
    res.json(totals);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

async function getCategoryTotalSale(category) {
  const orders = await Order.find({ 'products.product.category': category });
  let totalSales = 0;
  for (let i = 0; i < orders.length; i++) {
    for (let j = 0; j < orders[i].products.length; j++) {
      totalSales +=
        orders[i].products[j].product.price * orders[i].products[j].quantity;
    }
  }
  return totalSales;
}

module.exports = adminRouter;
