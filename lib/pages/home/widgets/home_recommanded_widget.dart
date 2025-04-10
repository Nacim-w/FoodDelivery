import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/pages/home/widgets/home_page_widgets.dart';

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
            color: Colours.lightThemeOrangeTextColor,
            borderRadius: BorderRadius.circular(20),
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
            formatText(text),
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
