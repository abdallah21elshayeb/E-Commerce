import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';

import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.isLiked});

  final Product product;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                    arguments: product);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.amberAccent,
                        ),
                        Image.network(product.images[0]),
                      ],
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Best Sale',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${product.price} \$',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
