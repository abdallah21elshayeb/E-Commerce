import 'package:flutter/material.dart';

import '../../components/mainComponent/declarations.dart';
import '../models/product.dart';
import '../services/home_service.dart';
import '../widgets/loader.dart';
import '../widgets/product_cart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.searchTxt}) : super(key: key);
  static const String routeName = '/search-screen';
  final String searchTxt;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productsList;
  HomeService homeService = HomeService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    productsList = await homeService.searchForProducts(
        context: context, txt: widget.searchTxt);
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
                'Search result for ${widget.searchTxt}',
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
                return ProductCard(
                  isLiked: false,
                  product: product,
                );
              }),
    );
  }
}
