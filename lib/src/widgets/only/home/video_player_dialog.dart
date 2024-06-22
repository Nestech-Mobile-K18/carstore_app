import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerDialog({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  double _currentSliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoUrl);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer(String videoUrl) {
    Uri videoUri = Uri.parse(videoUrl);

    _controller = VideoPlayerController.networkUrl(
      videoUri,
    );

    _controller.addListener(() {
      final bool isPlaying = _controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
      if (_controller.value.isInitialized) {
        setState(() {
          _currentSliderValue = _controller.value.position.inSeconds.toDouble();
        });
      }
    });

    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {}); // Make sure to update status if mounted
        _controller.setLooping(true);
        if (!_isFullScreen) {
          _controller
              .pause(); // Pause video on initialization if not in full screen mode
        }
      }
    }).catchError((error) {
      //print('Lỗi khi khởi tạo video: $error');
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause(); // Pause the video if it's playing
    } else {
      _controller.play(); // Play video if paused
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        // If switching to full screen and the video is playing, continue playing the video
        if (_controller.value.isPlaying) {
          _controller.play();
        }
      }
    });
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentSliderValue = value;
      Duration newPosition = Duration(seconds: value.toInt());
      _controller.seekTo(newPosition);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }

  Widget _buildDialog(BuildContext context) {
    if (_isFullScreen) {
      // If full screen, use full screen dialog
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(true);
        },
        child: Material(
          color: ColorsGlobal.globalTransparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                _togglePlayPause(); // Toggle play/pause khi chạm vào màn hình
              },
              child: AspectRatio(
                aspectRatio: _controller.value.isInitialized
                    ? _controller.value.aspectRatio * 0.8
                    : 16 / 9, // Default rate if not initialized
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    if (!_isPlaying)
                      const Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: ColorsGlobal.globalWhite,
                      ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildFullScreenControls(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      // If not full screen, use regular dialog
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.isInitialized
                  ? _controller.value.aspectRatio
                  : 16 / 9, // Default rate if not initialized
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  if (!_isPlaying)
                    const Icon(
                      Icons.play_arrow,
                      size: 50,
                      color: ColorsGlobal.globalWhite,
                    ),
                ],
              ),
            ),
            Positioned.fill(
              child: IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 50,
                  color: ColorsGlobal.globalWhite,
                ),
                onPressed: _togglePlayPause,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildControls(),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: ColorsGlobal.globalWhite,
            ),
            onPressed: _togglePlayPause,
          ),
          Expanded(
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: _controller.value.duration.inSeconds.toDouble(),
              onChanged: _onSliderChanged,
              activeColor: ColorsGlobal.globalWhite,
              inactiveColor: ColorsGlobal.globalGrey,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.fullscreen,
              size: 30,
              color: ColorsGlobal.globalWhite,
            ),
            onPressed: _toggleFullScreen,
          ),
          Text(
            _formatDuration(_controller.value.duration),
            style: const TextStyle(color: ColorsGlobal.globalWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenControls() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: ColorsGlobal.globalBlack.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: ColorsGlobal.globalWhite,
                ),
                onPressed: _togglePlayPause,
              ),
              Expanded(
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: _controller.value.duration.inSeconds.toDouble(),
                  onChanged: _onSliderChanged,
                  activeColor: ColorsGlobal.globalWhite,
                  inactiveColor: ColorsGlobal.globalGrey,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.fullscreen_exit,
                  size: 30,
                  color: ColorsGlobal.globalWhite,
                ),
                onPressed: _toggleFullScreen,
              ),
              Text(
                _formatDuration(_controller.value.duration),
                style: const TextStyle(color: ColorsGlobal.globalWhite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
