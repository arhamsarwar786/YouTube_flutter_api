import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideo extends StatefulWidget {
  final videoId;
  ShowVideo(this.videoId);
  @override
  _ShowVideoState createState() => _ShowVideoState(videoId);
}

class _ShowVideoState extends State<ShowVideo> {
  final videoId;
  _ShowVideoState(this.videoId);
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    youTubeDataFun();
  }

  youTubeDataFun() async {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Hero(
            tag: "video",
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left_outlined,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
                elevation: 1,
              ),
              body: Container(
                // height: 200,
                width: 400,
                color: Colors.red,
                child: player,
              ),
            ),
          );
        });
  }
}
