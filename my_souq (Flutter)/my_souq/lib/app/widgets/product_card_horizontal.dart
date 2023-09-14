import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/app/widgets/stars_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating > 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 130,
              ),
              if (AppLocalizations.of(context)!.localeName == 'ar')
                SizedBox(
                  width: 5,
                ),
              Column(
                children: [
                  Container(
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
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: StarsBar(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                        AppLocalizations.of(context)!.eligibleForFreeShipping),
                  ),
                  Container(
                    width: 205,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.inStock,
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
