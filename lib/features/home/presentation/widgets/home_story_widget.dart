import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/model/story_model.dart';
import 'package:legy/features/home/presentation/widgets/story_viewer.dart';

class HomeStoryWidget extends StatelessWidget {
  final List<StoryItemModel> stories = [
    StoryItemModel(username: 'Alice', imageUrls: [
      'https://picsum.photos/500/800?1',
      'https://picsum.photos/500/800?2',
      Media.story1,
    ]),
    StoryItemModel(username: 'Bob', imageUrls: [
      'https://picsum.photos/500/800?3',
      'https://picsum.photos/500/800?4',
      Media.story2,
    ]),
    StoryItemModel(username: 'Charlie', imageUrls: [
      'https://picsum.photos/500/800?5',
      'https://picsum.photos/500/800?6',
      Media.story3,
    ]),
    StoryItemModel(username: 'Alex', imageUrls: [
      'https://picsum.photos/500/800?5',
      'https://picsum.photos/500/800?6',
      Media.story4,
    ]),
    StoryItemModel(username: 'Sydney', imageUrls: [
      'https://picsum.photos/500/800?5',
      'https://picsum.photos/500/800?6',
      Media.story5,
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiUserStoryViewer(stories: stories),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(story.imageUrls.last),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    story.username,
                    style: TextStyles.textMediumSmall.white1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
