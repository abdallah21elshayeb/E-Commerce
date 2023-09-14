import 'package:flutter/material.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: Declarations.appBarGradient2,
      ),
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Text(
                '${AppLocalizations.of(context)!.addressOf} - ${user.name}, ${user.address}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 5,
            ),
            child: Icon(Icons.arrow_drop_down_outlined),
          ),
        ],
      ),
    );
  }
}
