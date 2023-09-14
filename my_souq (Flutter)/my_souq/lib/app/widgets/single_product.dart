import 'package:flutter/material.dart';

import '../models/product.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({
    Key? key,
    required this.product,
    this.myIcon,
    this.function,
  }) : super(key: key);

  final Product product;
  final IconData? myIcon;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 180,
              padding: const EdgeInsets.all(10),
              child: Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 100,
              ),
            ),
            Container(
              height: 20,
              width: 205,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 120,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
