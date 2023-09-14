import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/components/error/errorHandling.dart';
import 'package:my_souq/components/utils/util.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/mainComponent/declarations.dart';
import '../models/order.dart';

class HomeService {
  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response getRes = await http.get(
        Uri.parse('$url01/api/get-products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(
          response: getRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(getRes.body).length; i++) {
              productsList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(getRes.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  Future<List<Product>> searchForProducts(
      {required BuildContext context, required String txt}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response getRes = await http.get(
        Uri.parse('$url01/api/get-products/search/$txt'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(
          response: getRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(getRes.body).length; i++) {
              productsList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(getRes.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  Future<List<Product>> dealOfProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$url01/api/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productsList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  Future<List<Order>> getMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$url01/api/my-orders'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}
