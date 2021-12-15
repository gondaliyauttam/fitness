import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  const ChewieListItem(
      {Key? key, required this.looping, required this.videoPlayerController})
      : super(key: key);

  final VideoPlayerController videoPlayerController;

  final bool looping;
  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController _chewieController;

  @override
  void initState() {
    print("helo veideo " + widget.videoPlayerController.toString());
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16 / 9,
        showControls: true,
        autoInitialize: true,
        autoPlay: true,
        looping: widget.looping,
        allowFullScreen: true,
        errorBuilder: (ctx, errormessage) {
          return const Center(
            child: Text('errormessage'),
          );
        });
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
