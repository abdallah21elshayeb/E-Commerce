import 'package:flutter/material.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  Declarations.unselectedNavBarColor.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
