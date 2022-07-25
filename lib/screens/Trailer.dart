import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtubeplayer/Model/youtube_model.dart';

class Trailer extends StatefulWidget {
  Trailer({Key? key, this.title = '', required this.videoUrl})
      : super(key: key);
  final String title;
  var videoUrl;

  @override
  _TrailerState createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  late YoutubePlayerController _ytbPlayerController;
  // List<YoutubeModel> videosList = [
  //   YoutubeModel(id: 1, youtubeId: 'jA14r2ujQ7s'),
  //   YoutubeModel(id: 2, youtubeId: 'UQGoVB_zMYQ'),
  //   YoutubeModel(id: 3, youtubeId: 'FLcRb289uEM'),
  //   YoutubeModel(id: 4, youtubeId: 'g2nMKzhkvxw'),
  //   YoutubeModel(id: 5, youtubeId: 'qoDPvFAk2Vg'),
  // ];

  @override
  void initState() {
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: widget.videoUrl,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _ytbPlayerController = YoutubePlayerController(
              initialVideoId: snapshot.data.toString(),
              params: YoutubePlayerParams(
                showFullscreenButton: true,
                autoPlay: true,
              ),
            );

            return _buildYtbView();
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        },
      )),
    );
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
          : Center(child: CircularProgressIndicator()),
    );
  }

  _buildMoreVideoTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 182, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "More videos",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // _buildMoreVideosView() {
  //   return Expanded(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 15),
  //       child: ListView.builder(
  //           itemCount: videosList.length,
  //           physics: AlwaysScrollableScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             return GestureDetector(
  //               onTap: () {
  //                 final _newCode = videosList[index].youtubeId;
  //                 _ytbPlayerController.load(_newCode);
  //                 _ytbPlayerController.stop();
  //               },
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height / 5,
  //                 margin: EdgeInsets.symmetric(vertical: 7),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(18),
  //                   child: Stack(
  //                     fit: StackFit.expand,
  //                     children: <Widget>[
  //                       Positioned(
  //                         child: CachedNetworkImage(
  //                           imageUrl:
  //                               "https://img.youtube.com/vi/${videosList[index].youtubeId}/0.jpg",
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       Positioned(
  //                         child: Align(
  //                           alignment: Alignment.center,
  //                           child: Image.asset(
  //                             'assets/ytbPlayBotton.png',
  //                             height: 30,
  //                             width: 30,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }),
  //     ),
  //   );
  // }
}
