import 'package:flutter/material.dart';

class HomeStory extends StatefulWidget {
  final String image;
  final String username;
  const HomeStory({super.key, required this.image, required this.username});

  @override
  State<HomeStory> createState() => _HomeStoryState();
}

class _HomeStoryState extends State<HomeStory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Image(
            image: AssetImage(
              widget.image,
            ),
          ),
          Text(
            widget.username,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
