import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/search_screen.dart';
import 'package:my_souq/app/widgets/address_bar.dart';
import 'package:my_souq/app/widgets/carousel_image.dart';
import 'package:my_souq/app/widgets/deal_of_day.dart';
import 'package:my_souq/app/widgets/main_drawer.dart';
import 'package:my_souq/app/widgets/top_categories.dart';
import '../../components/mainComponent/declarations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void searchForProduct(String txt) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: txt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Declarations.secondaryColor,
            size: 30,
          ),
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: Declarations.backgroundColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: searchForProduct,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Declarations.secondaryColor,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 219, 219, 219),
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: AppLocalizations.of(context)!.searchInSouq),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Declarations.secondaryColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBar(),
            const SizedBox(height: 10),
            const TopCategories(),
            const SizedBox(height: 20),
            const CarouselImage(),
            const SizedBox(height: 10),
            const DealOfDay(),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
            ),
            Container(
              alignment: AppLocalizations.of(context)!.localeName == 'ar'
                  ? Alignment.topRight
                  : Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 10,
                top: 15,
                bottom: 10,
                right: 10,
              ),
              child: Text(
                AppLocalizations.of(context)!.offer,
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
            const SizedBox(height: 10),
            const Offers(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
