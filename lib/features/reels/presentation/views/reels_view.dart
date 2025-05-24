import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    WidgetsBinding.instance.addObserver(this);
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: youtubeUrls.length,
        onPageChanged: (index) {
          _disposeController();
          setState(() {
            _currentIndex = index;
            _isPaused = false;
            _isLoved = false;
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
                        GestureDetector(
                          onTap: _toggleLove,
                          child: Column(
                            children: [
                              Icon(
                                _isLoved
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isLoved ? Colors.red : Colors.white,
                                size: 32,
                              ),
                              const Text('1.2K',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
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
