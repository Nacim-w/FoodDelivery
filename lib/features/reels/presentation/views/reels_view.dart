import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});
  static const String routePath = '/reels';

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
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

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _pageController = PageController();
    _initializeControllerForIndex(_currentIndex);
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
  }

  @override
  void dispose() {
    _disposeController();
    _pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: youtubeUrls.length,
        onPageChanged: (index) {
          _disposeController();
          setState(() {
            _currentIndex = index;
            _initializeControllerForIndex(index);
          });
        },
        itemBuilder: (context, index) {
          return index == _currentIndex && _currentController != null
              ? YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _currentController!,
                    showVideoProgressIndicator: false,
                  ),
                  builder: (context, player) =>
                      _buildVideoOverlay(player, index),
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
                          const SizedBox(height: 4),
                          Row(
                            children: const [
                              Icon(Icons.music_note,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text('Trending audio',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAction(Icons.favorite, '1.2K'),
                        const SizedBox(height: 16),
                        _buildAction(Icons.comment, '120'),
                        const SizedBox(height: 16),
                        _buildAction(Icons.bookmark, ''),
                        const SizedBox(height: 16),
                        _buildAction(Icons.share, ''),
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

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        if (label.isNotEmpty)
          Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
