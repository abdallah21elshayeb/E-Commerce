import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Declarations.carouselImages.map((e) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            e,
            fit: BoxFit.cover,
            height: 200,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
        autoPlay: true,
      ),
    );
  }
}
