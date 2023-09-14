import 'package:flutter/material.dart';
import 'package:my_souq/app/widgets/below_app_bar.dart';
import 'package:my_souq/app/widgets/top_buttons.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';

import '../widgets/orders.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButtons(),
          SizedBox(
            height: 10,
          ),
          Orders(),
        ],
      ),
    );
  }
}
