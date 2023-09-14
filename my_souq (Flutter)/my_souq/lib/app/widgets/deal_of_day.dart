import 'package:flutter/material.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:my_souq/app/widgets/product_card_horizontal.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';
import '../services/home_service.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? productList;
  HomeService homeService = HomeService();
  @override
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
    return Column(
      children: [
        Container(
          alignment: AppLocalizations.of(context)!.localeName == 'ar'
              ? Alignment.topRight
              : Alignment.topLeft,
          padding:
              const EdgeInsets.only(left: 10, top: 15, bottom: 10, right: 10),
          child: Text(
            AppLocalizations.of(context)!.dealOfTheDay,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Declarations.secondaryColor,
            ),
          ),
        ),
        const Divider(
          thickness: 0.5,
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: productList == null
              ? const Loader()
              : ListView.builder(
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: productList![index],
                        );
                      },
                      child: ProductCardHorizontal(
                        product: productList![index],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
