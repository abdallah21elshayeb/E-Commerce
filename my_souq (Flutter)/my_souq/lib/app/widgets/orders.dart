import 'package:flutter/material.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/utils/util.dart';
import '../models/order.dart';
import '../screens/order_details_screen.dart';
import '../services/home_service.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  HomeService homeService = HomeService();
  @override
  void initState() {
    super.initState();
    getAllUserOrders();
  }

  void getAllUserOrders() async {
    orders = await homeService.getMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.orders,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // table Head
              TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  children: [
                    tableHeader(AppLocalizations.of(context)!.order),
                    tableHeader(AppLocalizations.of(context)!.amount),
                    tableHeader(AppLocalizations.of(context)!.status),
                    tableHeader(''),
                  ]),
              //table data
              if (orders != null)
                for (int i = 0; i < orders!.length; i++)
                  tableRow(context,
                      image: orders![i].products[0].images[0],
                      amount: orders![i].totalPrice.toString(),
                      status: orders![i].status,
                      index: (i + 1).toString(),
                      i: i)
            ],
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context,
      {index, image, amount, required int status, required int i}) {
    return TableRow(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    image,
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(index)
              ],
            ),
          ),
          Text(amount),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: getStatusColor(status)),
                height: 10,
                width: 9,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(getStatus(status)),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                  arguments: orders![i]);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Declarations.secondaryColor,
                  borderRadius: BorderRadius.circular(100)),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.view,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
