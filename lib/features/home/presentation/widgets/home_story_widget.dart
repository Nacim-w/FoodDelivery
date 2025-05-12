import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
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
      padding: EdgeInsets.only(
          left: 0.045 * context.width, top: 0.03 * context.width),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => {},
            child: Container(
              width: context.width * 0.19,
              height: context.width * 0.19,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: context.width * 0.075,
                backgroundImage: AssetImage(widget.image),
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
  HomeStory(username: 'Votre Story', image: Media.story4),
  HomeStory(username: 'Votre Story', image: Media.story2),
  HomeStory(username: 'Votre Story', image: Media.story3),
  HomeStory(username: 'Votre Story', image: Media.story5),
];
