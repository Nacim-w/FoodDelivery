import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class HomeStory extends StatefulWidget {
  final String image;
  final String username;
  final bool seen;
  final String id;
  const HomeStory(
      {super.key,
      required this.image,
      required this.username,
      required this.seen,
      required this.id});

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
                border: Border.all(
                  color: widget.seen == false
                      ? Colours.lightThemeOrange5.withAlpha(80)
                      : Colours.lightThemeOrange5.withAlpha(200),
                  width: 3,
                ),
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
            style: TextStyles.textSemiBoldSmall.black1,
          ),
        ],
      ),
    );
  }
}

List<Widget> stories = [
  HomeStory(id: "1", username: "test", image: Media.story1, seen: true),
  HomeStory(id: "2", username: "test", image: Media.story2, seen: true),
  HomeStory(id: "3", username: "test", image: Media.story3, seen: false),
  HomeStory(id: "4", username: "test", image: Media.story2, seen: true),
  HomeStory(id: "5", username: "test", image: Media.story1, seen: false),
];
