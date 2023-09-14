import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';
import '../services/home_service.dart';
import 'loader.dart';
import 'offer_product.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<Product>? productList;
  HomeService homeService = HomeService();
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productList = await homeService.dealOfProducts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : Container(
            height: 235,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList!.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailsScreen.routeName,
                      arguments: productList![index],
                    );
                  },
                  child: OfferProduct(
                    product: productList![index],
                  ),
                );
              }),
            ),
          );
  }
}
