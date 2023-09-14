import 'package:flutter/material.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: Declarations.appBarGradient,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: AppLocalizations.of(context)!.hello,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
