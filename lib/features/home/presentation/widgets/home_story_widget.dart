import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/model/story_model.dart';
import 'package:legy/features/home/presentation/widgets/story_viewer.dart';

class HomeStoryWidget extends StatelessWidget {
  final List<StoryItemModel> stories = [
    StoryItemModel(storyId: '1', username: 'Alice', imageUrls: [
      'https://legy-application-bucket.s3.eu-north-1.amazonaws.com/stories/9f85826c-0814-4af5-b211-191d5c095892-pizza-advertisement-on-instagram-design-template-856fb0e881df38659aafab91f3504f95_screen.jpg',
      'https://picsum.photos/id/292/500/800',
      Media.story1,
    ]),
    StoryItemModel(storyId: '2', username: 'Bob', imageUrls: [
      'https://picsum.photos/id/429/500/800',
      'https://picsum.photos/id/431/500/800',
      Media.story2,
    ]),
    StoryItemModel(storyId: '3', username: 'Charlie', imageUrls: [
      'https://picsum.photos/id/674/500/800',
      'https://picsum.photos/id/755/500/800',
      Media.story3,
    ]),
    StoryItemModel(storyId: '4', username: 'Alex', imageUrls: [
      'https://picsum.photos/id/835/500/800',
      'https://picsum.photos/id/889/500/800',
      Media.story4,
    ]),
    StoryItemModel(storyId: '5', username: 'Sydney', imageUrls: [
      'https://picsum.photos/id/766/500/800',
      'https://picsum.photos/id/785/500/800',
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
