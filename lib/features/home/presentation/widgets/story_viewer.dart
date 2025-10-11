import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:share_plus/share_plus.dart';
import 'package:story_view/story_view.dart';
import 'package:legy/features/home/model/story_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiUserStoryViewer extends StatefulWidget {
  final List<StoryItemModel> stories;
  final int initialPage;

  MultiUserStoryViewer({required this.stories, this.initialPage = 0});

  @override
  _MultiUserStoryViewerState createState() => _MultiUserStoryViewerState();
}

class _MultiUserStoryViewerState extends State<MultiUserStoryViewer> {
  late PageController _pageController;
  final Map<String, bool> _likedStories = {};
  final Map<String, StoryController> _storyControllers = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);

    // Initialize StoryControllers for all stories
    for (var story in widget.stories) {
      _storyControllers[story.storyId] = StoryController();
    }

    // Load all likes once
    _loadAllLikedStatuses();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _storyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _goToNextUser() {
    if (_pageController.page! < widget.stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  // Load all like statuses
  Future<void> _loadAllLikedStatuses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('likedStories') ?? '{}';
    final Map<String, dynamic> likedMap = json.decode(jsonString);
    setState(() {
      for (var story in widget.stories) {
        _likedStories[story.storyId] = likedMap[story.storyId] ?? false;
      }
    });
  }

  // Save like status map
  Future<void> _saveLikedStories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('likedStories', json.encode(_likedStories));
  }

  void _toggleLike(String storyId) {
    setState(() {
      _likedStories[storyId] = !(_likedStories[storyId] ?? false);
    });
    _saveLikedStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.stories.length,
        itemBuilder: (context, index) {
          final story = widget.stories[index];
          final controller = _storyControllers[story.storyId]!;
          final isLiked = _likedStories[story.storyId] ?? false;

          return Stack(
            children: [
              // Story images
              StoryView(
                controller: controller,
                storyItems: story.imageUrls.map((url) {
                  return StoryItem.pageImage(
                    url: url,
                    controller: controller,
                    imageFit: BoxFit.cover,
                  );
                }).toList(),
                onComplete: _goToNextUser,
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) Navigator.pop(context);
                },
              ),

              // Top: restaurant info
              Positioned(
                top: 70,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: (story.restaurantLogoUrl != null &&
                              story.restaurantLogoUrl!.startsWith('http'))
                          ? NetworkImage(story.restaurantLogoUrl!)
                          : AssetImage(story.restaurantLogoUrl ??
                              'assets/default_logo.png') as ImageProvider,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        story.restaurantName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom: Instagram-style reply + heart + share
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    // Reply input (does nothing)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              "Send message",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Heart button
                    GestureDetector(
                      onTap: () => _toggleLike(story.storyId),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Share button
                    GestureDetector(
                      onTap: () async {
                        if (story.imageUrls.isNotEmpty) {
                          final imageUrl = story.imageUrls.first;
                          await Share.share('Check out this story: $imageUrl');
                        } else {
                          await Share.share(
                              'Check out this story from ${story.restaurantName}!');
                        }
                      },
                      child: const Icon(Icons.near_me,
                          color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
