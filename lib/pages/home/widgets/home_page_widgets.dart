import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/common/res/media.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(right: 30),
          child: SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset(
              Media.orders,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 70),
          child: GestureDetector(
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                RichText(
                  text: TextSpan(
                    text: "Location\n",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: "Dakar, Senegal",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //icon button
        IconButton(
          onPressed: () {},
          icon: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  "assets/icons/cart.png",
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

String formatText(String name) {
  List<String> words = name.split(' '); // Split the name into words
  if (words.length > 1) {
    return '${words.first}\n${words.sublist(1).join(' ')}'; // Put the first word on one line, rest on the next
  }
  return name; // If it's a single word, return as is
}

Widget buildCard() {
  return Stack(
    children: [
      Container(
        height: 100,
        width: 500,
        decoration: BoxDecoration(
          color: Color(0xFFFFF7F6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage("assets/images/restaurant.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ))
    ],
  );
}
