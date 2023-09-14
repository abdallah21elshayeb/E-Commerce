import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/product.dart';
import 'package:my_souq/components/error/errorHandling.dart';
import 'package:my_souq/components/utils/util.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/mainComponent/declarations.dart';
import '../models/order.dart';
import '../models/sales.dart';

class AdminService {
  void saveProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudImgs = CloudinaryPublic('dymlvgina', 'krgob6f3');
      List<String> imgsUrls = [];

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse imgRes = await cloudImgs.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: category),
        );
        imgsUrls.add(imgRes.secureUrl);

        Product product = Product(
            name: name,
            description: description,
            price: price,
            quantity: quantity,
            category: category,
            images: imgsUrls);

        http.Response res = await http.post(
          Uri.parse('$url01/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'souq-elshayeb-auth-token': userProvider.user.token
          },
          body: product.toJson(),
        );
        print(res);
        httpErrorHandel(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Your product has been added :)');
              Navigator.pop(context);
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response getRes = await http.get(
        Uri.parse('$url01/admin/get-products'),
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

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response getRes =
          await http.post(Uri.parse('$url01/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'souq-elshayeb-auth-token': userProvider.user.token
              },
              body: jsonEncode({'id': product.id}));

      httpErrorHandel(
          response: getRes,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> getAllOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$url01/api/all-orders-admin'),
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
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$url01/admin/update-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
        body: jsonEncode(
          {
            'id': order.id,
            'status': status,
          },
        ),
      );
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getTotalSales(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalSales = 0;
    double totalOrders = 0;
    double totalProducts = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$url01/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': userProvider.user.token
        },
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            var result = jsonDecode(res.body);
            totalSales = Declarations.checkDouble(result['totalSales'] ?? 0.0);
            totalOrders =
                Declarations.checkDouble(result['totalOrders'] ?? 0.0);
            totalProducts =
                Declarations.checkDouble(result['totalProducts'] ?? 0.0);
            sales = [
              Sales(
                  label: 'Mobiles',
                  totalSale:
                      Declarations.checkDouble(result['catMobiles'] ?? 0.0)),
              Sales(
                  label: 'Appliances',
                  totalSale:
                      Declarations.checkDouble(result['catAppliances'] ?? 0.0)),
              Sales(
                  label: 'Fashion',
                  totalSale:
                      Declarations.checkDouble(result['catFashion'] ?? 0.0)),
              Sales(
                  label: 'Essentials',
                  totalSale:
                      Declarations.checkDouble(result['catEssentials'] ?? 0.0)),
              Sales(
                  label: 'Computers',
                  totalSale:
                      Declarations.checkDouble(result['catComputers'] ?? 0.0)),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalSales': totalSales,
      'totalOrders': totalOrders,
      'totalProducts': totalProducts
    };
  }
}
