import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_souq/app/services/admin_service.dart';
import 'package:my_souq/app/widgets/custom_button.dart';
import 'package:my_souq/app/widgets/custom_text.dart';
import 'package:my_souq/components/utils/util.dart';
import '../../components/mainComponent/declarations.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  static const String routeName = '/add-product';
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final AdminService adminService = AdminService();

  String category = 'Mobiles';
  List<File> images = [];

  final _addProductForm = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void pickAnImage() async {
    var resImg = await pickImages();
    setState(() {
      images = resImg;
    });
  }

  void addProduct() {
    if (_addProductForm.currentState!.validate() && images.isNotEmpty) {
      adminService.saveProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: Declarations.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 95,
                  height: 45,
                ),
              ),
              const Text(
                'Add Product',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((e) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              e,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                          autoPlay: false,
                        ),
                      )
                    : GestureDetector(
                        onTap: pickAnImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                    controller: productNameController, hintTxt: 'product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                    controller: descriptionController,
                    hintTxt: 'description',
                    maxLines: 4),
                const SizedBox(
                  height: 10,
                ),
                CustomText(controller: priceController, hintTxt: 'price'),
                const SizedBox(
                  height: 10,
                ),
                CustomText(controller: quantityController, hintTxt: 'quantity'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: Declarations.catImages.map((e) {
                      return DropdownMenuItem(
                        value: e['title']!,
                        child: Text(e['title']!),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        category = val!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(text: 'Save', onTap: addProduct),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
