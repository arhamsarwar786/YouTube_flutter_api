import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube/Screens/searchBarGet.dart';
import 'package:youtube/Screens/showVideo.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "YouTube",
      home: Home("Mind"),
    );
  }
}

class Home extends StatefulWidget {
  final query;
  Home(this.query);
  // VideoPlayerController videoPlayerController;
  // Home(this.videoPlayerController);
  @override
  _HomeState createState() => _HomeState(query);
}

class _HomeState extends State<Home> {
  final query;
  _HomeState(this.query);
  var videoId = '', thumnail = '', title = '', channalTitle = '';
  dynamic items = 0, item, index;

  @override
  void initState() {
    super.initState();
    youTubeData();
  }

  Future<void> youTubeData() async {
    var res = await get(
        'https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=$query&key=AIzaSyBXXTel4jmofkAjKMjq60pqep61fBB600E&maxResults=50');
    var data = jsonDecode(res.body);
    print(data['items'][0]['id']['videoId']);
    item = data['items'];
    items = data['pageInfo']['resultsPerPage'];
    // title=
    print(items);

    videoId = '${data['items'][0]['id']['videoId']}';

    // thumnail=data['items'][0]['snippet']['thumbnails']['high'];
  }

  // YoutubePlayerController _controller;
  // final url = 'https://www.youtube.com/embed/a_9fZmS02ro';

  // youTubeDataFun();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   _controller.pause();
  // }

  // youTubeDataFun() async {
  //   _controller = YoutubePlayerController(
  //     initialVideoId: videoId,
  //     flags: YoutubePlayerFlags(
  //       enableCaption: true,
  //       isLive: false,
  //       autoPlay: true,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var totalSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 50,
        title: Image.asset(
          'images/youtubelogo.png',
          height: 20,
          width: 80,
          fit: BoxFit.fill,
          // width: 200,
        ),
        actions: [
          // Icon(),

          IconButton(
              icon: Icon(
                Icons.view_stream_rounded,
                color: Colors.grey,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPressed: () {
                // setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchBar()),
                );
                // });
              }),

          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('images/dslrnew.jpg'),
            // child: Image.asset('images/dslrnew.jpg'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: youTubeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              onRefresh: youTubeData,
              child: InkWell(
                child: Hero(
                  tag: "video",
                  child: Container(
                    height: totalSize.height,
                    width: totalSize.width,
                    child: ListView.builder(
                      itemCount: items,
                      itemBuilder: (context, i) {
                        index = i;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: totalSize.height * 0.35,
                            width: totalSize.width,
                            // color: Colors.yellow,
                            child: Column(
                              children: [
                                Container(
                                  // height: totalSize.height * 0.30,
                                  // width: totalSize.width,
                                  // color: Colors.grey,
                                  child: Image.network(
                                    '${item[i + 1]['snippet']['thumbnails']['medium']['url']}',
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  width: totalSize.width * 0.80,
                                  height: totalSize.height * 0.10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${item[i]['snippet']['title']}",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Text(
                                        "${item[i]['snippet']['channelTitle']}",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                onTap: () {
                  videoId = item[index - 1]['id']['videoId'];
                  print(videoId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowVideo(videoId),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

////////////////////////////    ImpORTANT ///////////////////
///
///
///
///
///
///
///

// YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: _controller,
//         ),
//         builder: (context, player) {
//           return Scaffold(
//             appBar: AppBar(),
//             body: Column(
//               children: [
//                 player,
//                 Text("YOUTUBE video"),
//               ],
//             ),
//           );
//         });

//////////////////////////////////////////////////////////////////////////
// Container(
//         child: ListView.builder(
//             itemCount: 10,
//             itemBuilder: (context, i) {
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                   height: totalSize.height * 0.20,
//                   width: totalSize.width,
//                   color: Colors.white,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: totalSize.height * 0.40,
//                         width: totalSize.width * 0.50,
//                         color: Colors.yellow,
//                       ),
//                       Container(
//                         child: Column(
//                           children: [
//                             Text("Title of Video"),
//                             Text("describtion"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       )

// FutureBuilder(
//         future: _initVideoPlayer,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return AspectRatio(
//               aspectRatio: videoPlayerController.value.aspectRatio,
//               child: VideoPlayer(videoPlayerController),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(videoPlayerController.value.isPlaying
//             ? Icons.pause
//             : Icons.play_arrow),
//         onPressed: () {
//           setState(() {
//             if (videoPlayerController.value.isPlaying) {
//               videoPlayerController.pause();
//             } else {
//               videoPlayerController.play();
//             }
//           });
//         },
//       ),
