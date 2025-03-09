import 'package:video_player/video_player.dart';

VideoPlayerController getVideoPlayerController(String url) {
  final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
    ..initialize();

  return videoPlayerController;
}
