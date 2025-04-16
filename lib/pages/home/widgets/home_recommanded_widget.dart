import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';

class HomeRecommanded extends StatelessWidget {
  final String image;
  final String text;
  final String price;
  const HomeRecommanded(
      {super.key,
      required this.image,
      required this.text,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          width: 150,
          decoration: BoxDecoration(
            color: Colours.lightThemeOrange5,
            borderRadius: BorderRadius.circular(37),
          ),
        ),
        Positioned(
          top: -10,
          child: Image.asset(
            image,
            width: 120,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 50,
          right: 70,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: Text(
            "\$$price",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> featuredItems = [
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured2.png",
    "price": "5.98",
  },
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured.png",
    "price": "5.98",
  },
  {
    "name": "Prawn mix salad",
    "image": "assets/images/featured.png",
    "price": "5.98",
  },
];
