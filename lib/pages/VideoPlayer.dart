
// import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task1/pages/m3uplaylist.dart';
import 'package:task1/pages/playlist.dart';
import 'package:video_player/video_player.dart';
class VideoPlayers extends StatefulWidget {

  final String link;
  final String title;
  const VideoPlayers({Key? key, required this.link, required this.title}) : super(key: key);

  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
   ChewieController? chewieController;
  //BetterPlayerController? _betterPlayerController;
   VideoPlayerController? videoPlayerController;
bool fullScreen = true;
bool initialize = false;
  @override
  void initState() {
    // TODO: implement initState

     videoPlayerController = VideoPlayerController.network(
        widget.link);
    chewieController = ChewieController(
      placeholder: Text(widget.title, style: TextStyle(
        color: Colors.white
      ),),
      overlay: Text(widget.title, style: TextStyle(
          color: Colors.white
      ),),
      showControlsOnInitialize: true,
      showOptions: true,
      autoInitialize: true,
      allowFullScreen: false,
      fullScreenByDefault: false,
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      showControls: true,
      aspectRatio: 16/9
      // customControls: CustomMaterialControls(),
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.landscapeRight,
      // ],
    );
    // if(chewieController!.videoPlayerController.value.isInitialized){
    //   setState((){
    //      initialize = true;
    //   });
    // }
    // BetterPlayerConfiguration betterPlayerConfiguration =
    // BetterPlayerConfiguration(
    //     aspectRatio: 16 / 9,
    //     fit: BoxFit.contain,
    //     autoDetectFullscreenDeviceOrientation: true);
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //   BetterPlayerDataSourceType.network,
    //   widget.link,
    //   useHlsSubtitles: true,
    // );
    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // _betterPlayerController!.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    //_betterPlayerController!.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    print(videoPlayerController!.value.isInitialized.toString() + "InitValue");
    return Scaffold(

body: Center(

  child:  Chewie(
    controller: chewieController!,
  )


),
    );
  }
}
