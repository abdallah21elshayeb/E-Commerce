import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/add_products.dart';
import 'package:my_souq/app/services/admin_service.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:my_souq/app/widgets/single_product.dart';

import '../../components/utils/util.dart';
import '../models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminService adminService = AdminService();
  List<Product>? products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
  }

  getAllProducts() async {
    products = await adminService.getAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                shrinkWrap: true,
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final theProduct = products![index];
                  return Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: SingleProduct(
                            product: theProduct,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: IconButton(
                              onPressed: () {
                                showAlertDialog(
                                  context,
                                  () {
                                    deleteProduct(theProduct, index);
                                    Navigator.pop(context);
                                  },
                                  'Delete Product',
                                  'Are you sure? to delete this product',
                                );
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
                tooltip: 'add product',
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.routeName);
                }),
          );
  }
}
