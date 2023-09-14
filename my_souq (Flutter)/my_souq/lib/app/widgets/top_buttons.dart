import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/admin_screen.dart';
import 'package:my_souq/app/services/auth_services.dart';
import 'package:my_souq/app/widgets/account_button.dart';
import 'package:my_souq/components/utils/util.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              AccountButton(
                  text: AppLocalizations.of(context)!.wishList, onClick: () {}),
              AccountButton(
                  text: AppLocalizations.of(context)!.logOut,
                  onClick: () {
                    showAlertDialog(context, () {
                      authService.logOut(context);
                    }, AppLocalizations.of(context)!.stop,
                        AppLocalizations.of(context)!.stopMsg);
                  }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (user.type == 'admin')
            Row(
              children: [
                AccountButton(
                    text: AppLocalizations.of(context)!.adminTools,
                    onClick: () {
                      Navigator.pushNamed(context, AdminScreen.routeName);
                    }),
              ],
            ),
        ],
      ),
    );
  }
}
