import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Trailer extends StatefulWidget {
  Trailer({Key? key, this.title = '', required this.videoUrl})
      : super(key: key);
  final String title;
  var videoUrl;

  @override
  _TrailerState createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  YoutubePlayerController? _ytbPlayerController;

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

    _ytbPlayerController?.close();
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
              params: const YoutubePlayerParams(
                showFullscreenButton: true,
                autoPlay: true,
              ),
            );

            return _buildYtbView();
          }
          return const Center(
            child: CircularProgressIndicator(),
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
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
