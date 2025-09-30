import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/model/story_model.dart';
import 'package:legy/features/home/presentation/widgets/story_viewer.dart';
import 'package:legy/core/extension/text_style_extension.dart';

class HomeStoryWidget extends StatelessWidget {
  final double avatarRadius = 30;
  final String fallbackLogoAsset = Media.restaurant1;

  final List<StoryItemModel> defaultStories = [
    StoryItemModel(
      storyId: "1",
      restaurantName: "Pasta House",
      restaurantLogoUrl: null,
      imageUrls: [
        "https://picsum.photos/400/700?1",
        "https://picsum.photos/400/700?2",
      ],
    ),
    StoryItemModel(
      storyId: "2",
      restaurantName: "Burger Spot",
      restaurantLogoUrl: null,
      imageUrls: [
        "https://picsum.photos/400/700?3",
        "https://picsum.photos/400/700?4",
      ],
    ),
    StoryItemModel(
      storyId: "3",
      restaurantName: "Sushi World",
      restaurantLogoUrl: null,
      imageUrls: [
        "https://picsum.photos/400/700?5",
        "https://picsum.photos/400/700?6",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: defaultStories.length,
        itemBuilder: (context, index) {
          final story = defaultStories[index];
          final restaurantName = story.restaurantName;
          final restaurantLogo = story.restaurantLogoUrl;

          return GestureDetector(
            onTap: () {
              // Fullscreen story push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MultiUserStoryViewer(
                    stories: defaultStories,
                    initialPage: index,
                  ),
                  fullscreenDialog: true, // full screen
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
                      border: Border.all(
                        color: Colours.lightThemeOrange0,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: restaurantLogo != null
                          ? NetworkImage(restaurantLogo)
                          : AssetImage(fallbackLogoAsset) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: avatarRadius * 2 + 6,
                    child: Text(
                      restaurantName.isNotEmpty ? restaurantName : "Unknown",
                      style: TextStyles.textMediumSmall.white1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
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
