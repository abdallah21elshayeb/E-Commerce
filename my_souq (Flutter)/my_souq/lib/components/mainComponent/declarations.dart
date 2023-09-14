import 'package:flutter/material.dart';

String url01 = "http://192.168.1.33:3020";

class Declarations {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 230, 230, 230),
      Color.fromARGB(255, 45, 97, 139),
    ],
    stops: [0.5, 1.0],
  );
  static const appBarGradient2 = LinearGradient(
    colors: [
      Color.fromARGB(255, 45, 97, 139),
      Color.fromARGB(255, 238, 238, 238),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 45, 97, 139);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color.fromARGB(255, 214, 204, 192);
  static var selectedNavBarColor = Color.fromARGB(255, 45, 97, 139);
  static const unselectedNavBarColor = Color.fromARGB(255, 31, 35, 36);
  static const List<Map<String, String>> catImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobile.png',
    },
    {
      'title': 'Computers',
      'image': 'assets/images/computer.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/clothes.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliance.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essential.png',
    },
  ];

  static const List<String> carouselImages = [
    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/35463b103211209.5f8d57c277188.jpg',
    'https://images.pexels.com/photos/12361692/pexels-photo-12361692.jpeg?auto=compress&cs=tinysrgb&w=1600',
    'https://images.pexels.com/photos/2885917/pexels-photo-2885917.jpeg?auto=compress&cs=tinysrgb&w=1600',
    'https://images.pexels.com/photos/1933587/pexels-photo-1933587.jpeg?auto=compress&cs=tinysrgb&w=1600',
    'https://images.pexels.com/photos/1661496/pexels-photo-1661496.jpeg?auto=compress&cs=tinysrgb&w=1600',
  ];

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    } else {
      return value;
    }
  }
}
