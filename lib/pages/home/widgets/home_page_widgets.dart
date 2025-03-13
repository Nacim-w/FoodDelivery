import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: 30),
            child: SizedBox(
              width: 25,
              height: 25,
              child: Image.asset(
                "assets/icons/menu.png",
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
    ),
  );
}

Widget buildStory(String username, String image) {
  return Padding(
    padding: EdgeInsets.only(left: 10),
    child: Column(
      children: [
        Image(
          image: AssetImage(
            image,
          ),
        ),
        Text(
          username,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildCategory(List categories) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  categories[index]['image']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                categories[index]['name']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
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

Widget buildFeatured(String text, String image, double price) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
        height: 160,
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xFFFF7300),
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
          formatText(text), // Automatically formats the name
          style: TextStyle(color: Colors.white, fontSize: 15),
          textAlign: TextAlign.center, // Ensures proper alignment
        ),
      ),
      Positioned(
        bottom: 50,
        right: 20,
        child: Text(
          "\$" + price.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ],
  );
}

Widget BuildCard() {
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
