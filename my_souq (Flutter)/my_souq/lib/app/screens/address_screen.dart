import 'package:flutter/material.dart';
import 'package:my_souq/app/services/product_service.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';
import '../../components/mainComponent/declarations.dart';
import '../../components/utils/util.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.totalAmount});

  static const String routeName = '/address';
  final String totalAmount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final ProductServices productServices = ProductServices();
  final TextEditingController _addressTxt = TextEditingController();
  final TextEditingController _homeTxt = TextEditingController();
  final TextEditingController _areaTxt = TextEditingController();
  final TextEditingController _specialTxt = TextEditingController();
  final _addressFormScreen = GlobalKey<FormState>();

  List<PaymentItem> _paymentItems = [];

  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('json/gpay.json');

    _paymentItems.add(
      PaymentItem(
        label: 'Total Price',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    // Send the resulting Google Pay token to your server / PSP
  }

  void payProceed(String theAddress, String paymentMethod) {
    bool formOk = _addressTxt.text.isNotEmpty ||
        _homeTxt.text.isNotEmpty ||
        _areaTxt.text.isNotEmpty ||
        _specialTxt.text.isNotEmpty;
    if (formOk) {
      if (_addressFormScreen.currentState!.validate()) {
        theAddress =
            "${_addressTxt.text},${_homeTxt.text},${_areaTxt.text},${_specialTxt.text}";
      } else {
        showAlertDialog2(context, 'Stop', 'Fill all address info');
      }
    } else {
      if (theAddress.isEmpty) {
        showAlertDialog2(context, 'Stop', 'Fill all address info');
      }
    }
    productServices.saveUserAddress(context: context, address: theAddress);
    productServices.setAnOrder(
        context: context,
        address: theAddress,
        totalPrice: double.parse(widget.totalAmount),
        paymentMethod: paymentMethod);
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressTxt.dispose();
    _homeTxt.dispose();
    _areaTxt.dispose();
    _specialTxt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address =
        Provider.of<UserProvider>(context, listen: false).user.address;
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
              'Address Screen',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Or you have new address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormScreen,
                child: Column(
                  children: [
                    CustomText(
                      controller: _addressTxt,
                      hintTxt: 'Address,',
                      icon: Icons.home_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      controller: _homeTxt,
                      hintTxt: 'Home, Number',
                      icon: Icons.streetview_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      controller: _areaTxt,
                      hintTxt: 'Area, Street',
                      icon: Icons.add_business_rounded,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      controller: _specialTxt,
                      hintTxt: 'Special Mark',
                      icon: Icons.mark_as_unread_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<PaymentConfiguration>(
                        future: _googlePayConfigFuture,
                        builder: (context, snapshot) => snapshot.hasData
                            ? GooglePayButton(
                                width: double.infinity,
                                paymentConfiguration: snapshot.data!,
                                paymentItems: _paymentItems,
                                type: GooglePayButtonType.buy,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: (paymentResult) {
                                  payProceed(address, "GPAY");
                                },
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink()),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () {
                        payProceed(address, "CASH");
                      },
                      text: 'Cash on delivery',
                      icon: Icons.money,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
