import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../services/live_service.dart';
import '../services/user_manager.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool _loading = true;
  String? _streamUrl;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isBuffering = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLive();
  }

  Future<void> _loadLive() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final live = await LiveService.fetchLive();
      debugPrint('Live data received: $live');

      if (live != null && live['is_active'] == true) {
        final url = live['stream_url'] as String?;
        debugPrint('Stream URL: $url');

        if (url != null && url.isNotEmpty) {
          setState(() => _streamUrl = url);
          await _initPlayer(url);
        } else {
          setState(() => _error = 'Stream URL is empty');
        }
      } else {
        setState(() => _error = 'No active stream');
      }
    } catch (e) {
      setState(() => _error = 'Failed to load stream: $e');
      debugPrint('Error loading live: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _initPlayer(String url) async {
    debugPrint('Initializing player with URL: $url');

    // Dispose any existing controllers
    await _disposeControllers();

    try {
      // Parse the URL
      final uri = Uri.parse(url);
      debugPrint('Parsed URI: $uri');

      // Create video controller (without VideoPlayerOptions to avoid platform channel issues)
      _videoController = VideoPlayerController.networkUrl(uri);

      // Add listener for state changes
      _videoController!.addListener(() {
        if (!mounted) return;

        final buffering = _videoController!.value.isBuffering;
        if (buffering != _isBuffering) {
          setState(() => _isBuffering = buffering);
        }

        // Log player state
        debugPrint(
          'Player state - Playing: ${_videoController!.value.isPlaying}, '
          'Buffering: ${_videoController!.value.isBuffering}, '
          'Initialized: ${_videoController!.value.isInitialized}',
        );

        // Check for errors
        if (_videoController!.value.hasError) {
          final errorMsg =
              _videoController!.value.errorDescription ?? 'Video player error';
          debugPrint('Video player error: $errorMsg');
          setState(() {
            _error = errorMsg;
          });
        }
      });

      debugPrint('Starting video controller initialization...');
      await _videoController!.initialize();
      debugPrint('Video controller initialized successfully');

      if (!mounted) return;

      // Get aspect ratio
      final aspectRatio = _videoController!.value.aspectRatio > 0
          ? _videoController!.value.aspectRatio
          : 16 / 9;

      debugPrint('Video aspect ratio: $aspectRatio');

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        aspectRatio: aspectRatio,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        autoInitialize: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: IndozTheme.accentOrange,
          handleColor: IndozTheme.accentOrange,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white54,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          debugPrint('Chewie error: $errorMessage');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      );

      debugPrint('Chewie controller created');

      if (mounted) {
        setState(() {
          _error = null;
        });
      }

      // Try to play
      await _videoController!.play();
      debugPrint('Play command sent');
    } on PlatformException catch (e, stackTrace) {
      // Platform channel failed (common on some emulators / restricted devices).
      debugPrint('Platform exception initializing player: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          _error =
              'Platform error initializing video player. You can open the stream in an external player.';
        });
      }
    } catch (e, stackTrace) {
      debugPrint('Error initializing player: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          _error = 'Failed to initialize: $e';
        });
      }
    }
  }

  Future<void> _disposeControllers() async {
    try {
      _chewieController?.dispose();
      _chewieController = null;
    } catch (e) {
      debugPrint('Error disposing chewie: $e');
    }

    try {
      await _videoController?.dispose();
      _videoController = null;
    } catch (e) {
      debugPrint('Error disposing video controller: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [IndozTheme.gradientStart, IndozTheme.gradientEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<String>(
                      future: UserManager.getUsername(),
                      builder: (context, snapshot) {
                        final username = snapshot.data ?? 'User';
                        return Text(
                          'Welcome, $username',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: _loadLive,
                      tooltip: 'Reload stream',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _error != null
                    ? _buildErrorView()
                    : _streamUrl == null
                    ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.live_tv, size: 80, color: Colors.white70),
                          SizedBox(height: 12),
                          Text(
                            'No live stream right now',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      )
                    : _buildPlayerView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 80, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Error loading live TV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Player container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    if (_chewieController != null &&
                        _videoController != null &&
                        _videoController!.value.isInitialized)
                      Chewie(controller: _chewieController!)
                    else
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 16),
                            Text(
                              'Connecting to stream...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_isBuffering &&
                        _videoController?.value.isInitialized == true)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Buffering...',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // LIVE badge removed per request
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Live Streaming Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay up to-date with real-time global events',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 20),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }
}
