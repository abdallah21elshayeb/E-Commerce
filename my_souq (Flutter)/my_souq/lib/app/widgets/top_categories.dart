import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/category_deal_screen.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void toCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealScreen.routeName,
        arguments: category);
  }

  String getName(String theName, BuildContext context) {
    switch (theName) {
      case "Mobiles":
        return AppLocalizations.of(context)!.mobiles;
      case "Appliances":
        return AppLocalizations.of(context)!.appliances;
      case "Fashion":
        return AppLocalizations.of(context)!.fashion;
      case "Essentials":
        return AppLocalizations.of(context)!.essentials;
      case "Computers":
        return AppLocalizations.of(context)!.computers;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLocalizations.of(context)!.localeName == "ar" ? 80 : 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 70,
          itemCount: Declarations.catImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                toCategoryPage(
                    context, Declarations.catImages[index]['title']!);
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      Declarations.catImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      getName(Declarations.catImages[index]['title']!, context))
                ],
              ),
            );
          }),
    );
  }
}
