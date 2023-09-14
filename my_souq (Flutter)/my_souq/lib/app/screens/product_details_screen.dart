import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_souq/app/widgets/stars_bar.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/mainComponent/declarations.dart';
import '../services/product_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  static const String routeName = '/product-detail';
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductServices productServices = ProductServices();
  double avgRating = 0;
  double userRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating = 0;
    var user = Provider.of<UserProvider>(context, listen: false).user;
    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId == user.id) {
        userRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating > 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
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
              Text(
                'Search result for ${widget.product.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  StarsBar(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((e) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price:',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.product.description),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Rate The Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: RatingBar.builder(
                  initialRating: userRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  itemBuilder: (context, _) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (rating) {
                    productServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating);
                  }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation:
          AppLocalizations.of(context)!.localeName == 'ar'
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        // direction: SpeedDialDirection.right,
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.deepPurpleAccent,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56, 56),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () {},
        onClose: () {},
        elevation: 8,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: "Add To Cart",
            labelStyle: const TextStyle(fontSize: 18),
            onTap: () {
              productServices.addProductToCart(
                  context: context, product: widget.product, quantity: 1);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.monetization_on_outlined),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: "Buy Now",
            labelStyle: const TextStyle(fontSize: 18),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
