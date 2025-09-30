import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/reels/presentation/app/adapter/reels_cubit.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});
  static const String routePath = '/reels';

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final List<String> youtubeUrls = [
    'https://www.youtube.com/shorts/Wo0smJajSuM',
    'https://www.youtube.com/shorts/zPxQjuFoUBc',
    'https://www.youtube.com/shorts/E17l76-8Tjw',
    'https://www.youtube.com/shorts/e3_ydoYMUFs',
    'https://www.youtube.com/shorts/vGDpLALJItE',
  ];

  late PageController _pageController;
  YoutubePlayerController? _currentController;
  int _currentIndex = 0;
  bool _isPaused = false;
  bool _isLoved = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<ReelsCubit>().loadReels();

    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _pageController = PageController();
    _initializeControllerForIndex(_currentIndex);
    _loadLikedStatus();
  }

  void _initializeControllerForIndex(int index) {
    final videoId = YoutubePlayer.convertUrlToId(youtubeUrls[index]) ?? '';
    _currentController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
        hideControls: true,
        disableDragSeek: true,
      ),
    );
  }

  void _disposeController() {
    _currentController?.pause();
    _currentController?.dispose();
    _currentController = null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    _pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocation = GoRouterState.of(context).uri.toString();
    if (!currentLocation.contains(ReelsView.routePath)) {
      _currentController?.pause();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _currentController?.pause();
    }
  }

  void _toggleVideoPlayback() {
    setState(() {
      _isPaused = !_isPaused;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentController != null && _currentController!.value.isReady) {
        if (_isPaused) {
          _currentController!.pause();
        } else {
          _currentController!.play();
        }
      }
    });
  }

  void _toggleLove() {
    setState(() {
      _isLoved = !_isLoved;
    });
    _saveLikedStatus();
  }

  Future<void> _shareReel() async {
    final videoUrl = youtubeUrls[_currentIndex];
    await Share.share('Check out this reel: $videoUrl');
  }

  Future<void> _loadLikedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('likedReels') ?? '{}';
    final Map<String, dynamic> likedMap = json.decode(jsonString);
    setState(() {
      _isLoved = likedMap[youtubeUrls[_currentIndex]] ?? false;
    });
  }

  Future<void> _saveLikedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('likedReels') ?? '{}';
    final Map<String, dynamic> likedMap = json.decode(jsonString);
    likedMap[youtubeUrls[_currentIndex]] = _isLoved;
    await prefs.setString('likedReels', json.encode(likedMap));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: youtubeUrls.length,
        onPageChanged: (index) async {
          _disposeController();
          setState(() {
            _currentIndex = index;
            _isPaused = false;
            _isLoved = false;
            _initializeControllerForIndex(index);
          });
          await _loadLikedStatus();
        },
        itemBuilder: (context, index) {
          return index == _currentIndex && _currentController != null
              ? YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _currentController!,
                    showVideoProgressIndicator: false,
                  ),
                  builder: (context, player) => _buildVideoOverlay(
                    GestureDetector(
                      onTap: _toggleVideoPlayback,
                      child: player,
                    ),
                    index,
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildVideoOverlay(Widget player, int index) {
    return Stack(
      children: [
        SizedBox.expand(child: player),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('@bramasquare${index + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text('Amazing content! 🌟',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Like button
                        GestureDetector(
                          onTap: _toggleLove,
                          child: Icon(
                            _isLoved ? Icons.favorite : Icons.favorite_border,
                            color: _isLoved ? Colors.red : Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Share button
                        GestureDetector(
                          onTap: _shareReel,
                          child: Icon(
                            Icons.near_me, // Instagram-style arrow
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
