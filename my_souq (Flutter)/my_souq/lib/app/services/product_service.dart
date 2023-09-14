import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/user.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:my_souq/app/models/product.dart';
import '../../components/error/errorHandling.dart';
import '../../components/mainComponent/declarations.dart';
import '../../components/utils/util.dart';

class ProductServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$url01/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'product has been rated successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addProductToCart(
      {required BuildContext context,
      required Product product,
      required double quantity}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res;

      if (quantity < 0) {
        res = await http.delete(
          Uri.parse('$url01/api/remove-from-cart/${product.id}'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'souq-elshayeb-auth-token': userProvider.user.token
          },
        );
      } else {
        res = await http.post(
          Uri.parse('$url01/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'souq-elshayeb-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id!,
            'quantity': quantity,
          }),
        );
      }

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              cart: jsonDecode(res.body)['cart'],
            );
            userProvider.setObjectUser(user);
            if (quantity > 0) {
              showSnackBar(context, 'product has been added successfully');
              // Navigator.pop(context);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$url01/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );
            userProvider.setObjectUser(user);
            showSnackBar(context, 'Ok Address Has been Updated');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void setAnOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
    required String paymentMethod,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$url01/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalPrice,
          'paymentMethod': paymentMethod,
        }),
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setObjectUser(user);
            showSnackBar(context, 'Ok Order send successfully :');

            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
