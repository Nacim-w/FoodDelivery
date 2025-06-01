import 'package:flutter/material.dart';
import 'package:legy/features/home/model/story_model.dart';
import 'package:story_view/story_view.dart';

class MultiUserStoryViewer extends StatefulWidget {
  final List<StoryItemModel> stories;
  final int initialPage;

  MultiUserStoryViewer({required this.stories, this.initialPage = 0});

  @override
  _MultiUserStoryViewerState createState() => _MultiUserStoryViewerState();
}

class _MultiUserStoryViewerState extends State<MultiUserStoryViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextUser() {
    if (_pageController.page! < widget.stories.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }

  void _goToPreviousUser() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.stories.length,
      itemBuilder: (context, index) {
        final userStory = widget.stories[index];
        final controller = StoryController();

        return StoryView(
          controller: controller,
          storyItems: userStory.imageUrls.map((url) {
            return StoryItem.pageImage(
              url: url,
              controller: controller,
              imageFit: BoxFit.cover,
            );
          }).toList(),
          onComplete: _goToNextUser,
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
