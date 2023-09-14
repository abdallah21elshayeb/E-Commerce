import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/product_details_screen.dart';
import 'package:my_souq/app/widgets/loader.dart';

import '../../components/mainComponent/declarations.dart';
import '../models/product.dart';
import '../services/home_service.dart';
import '../widgets/single_product.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({Key? key, required this.category})
      : super(key: key);
  static const String routeName = '/category-deal';
  final String category;

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productsList;
  HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productsList = await homeService.getCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Declarations.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 95,
                  height: 45,
                ),
              ),
              Text(
                widget.category,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: productsList == null
          ? const Loader()
          : GridView.builder(
              padding: const EdgeInsets.only(left: 10, top: 10),
              itemCount: productsList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = productsList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailsScreen.routeName,
                      arguments: product,
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 175,
                        child: SingleProduct(
                          product: product,
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
