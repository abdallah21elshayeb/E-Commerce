import 'package:flutter/material.dart';
import 'package:my_souq/app/models/order.dart';
import 'package:my_souq/app/screens/add_products.dart';
import 'package:my_souq/app/screens/address_screen.dart';
import 'package:my_souq/app/screens/admin_screen.dart';
import 'package:my_souq/app/screens/auth_screen.dart';
import 'package:my_souq/app/screens/category_deal_screen.dart';
import 'package:my_souq/app/screens/home_screen.dart';
import 'package:my_souq/app/screens/order_details_screen.dart';
import 'package:my_souq/app/screens/signUp_screen.dart';
import 'package:my_souq/app/widgets/custom_bottom_bar.dart';

import 'app/models/product.dart';
import 'app/screens/product_details_screen.dart';
import 'app/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case SearchScreen.routeName:
      var txt = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchTxt: txt),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: product),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(order: order),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('No Data here :('),
                ),
              ));
  }
}
