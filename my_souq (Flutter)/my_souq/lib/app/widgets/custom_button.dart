import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.icon,
      this.color});

  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return icon == null
        ? ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: color,
            ),
            child: Text(text),
          )
        : ElevatedButton.icon(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            icon: Icon(
              icon,
              size: 25,
            ),
            label: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          );
  }
}
