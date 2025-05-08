import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';

class HomeStory extends StatefulWidget {
  final String image;
  final String username;
  const HomeStory({
    super.key,
    required this.image,
    required this.username,
  });

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
          GestureDetector(
            onTap: () => {},
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage(
                  widget.image,
                ),
              ),
            ),
          ),
          Text(
            widget.username,
            style: TextStyles.textMediumSmall.white1,
          ),
        ],
      ),
    );
  }
}

List<Widget> stories = [
  HomeStory(username: 'Votre Story', image: Media.story1),
  HomeStory(username: 'Votre Story', image: Media.story2),
  HomeStory(username: 'Votre Story', image: Media.story3),
  HomeStory(username: 'Votre Story', image: Media.story2),
  HomeStory(username: 'Votre Story', image: Media.story1),
];
