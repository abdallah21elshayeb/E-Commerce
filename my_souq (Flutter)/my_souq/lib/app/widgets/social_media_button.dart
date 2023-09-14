import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class SocialMediaButton extends StatelessWidget {
  IconData? icon;
  Color? color;
  final void Function()? onClicked;
  SocialMediaButton({this.icon, this.color, this.onClicked});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        width: 64,
        height: 64,
        child: Center(
          child: FaIcon(
            icon,
            color: color,
            size: 40,
          ),
        ),
      ),
    );
  }
}
