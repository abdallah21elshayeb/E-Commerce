import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/product.dart';

class OfferProduct extends StatelessWidget {
  const OfferProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
              height: 20,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                    BorderRadius.circular(10), // Adjust the radius as needed
              ),
              margin: const EdgeInsets.only(
                top: 5,
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.offer,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 180,
              padding: const EdgeInsets.all(10),
              child: Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 100,
              ),
            ),
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
                padding: AppLocalizations.of(context)!.localeName == 'ar'
                    ? const EdgeInsets.only(right: 10, top: 5)
                    : const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '\$500.0',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 3,
                  ),
                )),
            Container(
              width: 205,
              padding: AppLocalizations.of(context)!.localeName == 'ar'
                  ? const EdgeInsets.only(right: 10, top: 5)
                  : const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
