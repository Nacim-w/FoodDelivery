import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/presentation/widgets/story_viewer.dart';

class HomeStoryWidget extends StatelessWidget {
  final double avatarRadius = 30;
  final String fallbackLogoAsset = Media.restaurant1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final stories = state.stories ?? [];

          if (stories.isEmpty) {
            return Center(
              child: Text(
                "No stories available",
                style: TextStyles.textMediumSmall.grey1,
              ),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiUserStoryViewer(
                        stories: stories,
                        initialPage: index,
                      ),
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
                              color: Colours.lightThemeOrange0, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: story.restaurantLogoUrl != null
                              ? NetworkImage(story.restaurantLogoUrl!)
                              : AssetImage(fallbackLogoAsset) as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: avatarRadius * 2 + 6,
                        child: Text(
                          story.restaurantName.isNotEmpty
                              ? story.restaurantName
                              : "Unknown",
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
          );
        },
      ),
    );
  }
}
