import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/address_screen.dart';
import 'package:my_souq/app/widgets/address_bar.dart';
import 'package:my_souq/app/widgets/cart_subtotal.dart';
import 'package:my_souq/app/widgets/custom_button.dart';
import 'package:my_souq/app/widgets/product_card_cart.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/mainComponent/declarations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: Declarations.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Cart Screen',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const AddressBar(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text:
                    '${AppLocalizations.of(context)!.proceedToBuy} (${user.cart.length} items)',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AddressScreen.routeName,
                    arguments: sum.toString(),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ProductCardCart(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
