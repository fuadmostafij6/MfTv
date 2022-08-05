import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

import 'package:task1/pages/playlist.dart';
import 'package:http/http.dart' as http;
import '../db/database.dart';
import '../model/PlaylistNameModel.dart';
import '../model/playlistmodel.dart';

class M3uProcessing extends StatefulWidget {
  final String urlText;
  final String playListsTitle;
  const M3uProcessing({Key? key, required this.urlText, required this.playListsTitle}) : super(key: key);

  @override
  State<M3uProcessing> createState() => _M3uProcessingState();
}

class _M3uProcessingState extends State<M3uProcessing>
    with SingleTickerProviderStateMixin {
  List<PlaylistsModel> tvList = [];
  List<PlaylistsNameModel> tvPlayLists = [];
  List<Datum> datum = [];
  List hiveTvList = [];
  bool error = false;
  bool processing = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    loadM3U();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  static const tvPlayList = ['Tv Playlist'];
  String selectedTvPlayList = "Tv Playlist";
  Future<void> loadM3U() async {
    try {
      setState((){
        processing =true;
      });
      final response = await http.get(Uri.parse(widget.urlText));
      final m3u = await M3uParser.parse(response.body);
      print(response.statusCode.toString()+"dsfas");

      if (response.statusCode == 200) {

        for (final entry in m3u) {
          setState(() {
            PlaylistsModel playlistsModel = PlaylistsModel(
             title:  entry.title,
              link: entry.link,
              logo: entry.attributes['tvg-logo'],
              playlistName: widget.playListsTitle
            );
            Datum datum1 = Datum(
                title:  entry.title,
                link: entry.link,
                logo: entry.attributes['tvg-logo'],
                playlistName: widget.playListsTitle
            );
            datum.add(datum1);


            PlaylistsNameModel playlistsNameModel = PlaylistsNameModel(
                data:datum ,
                playlistName: widget.playListsTitle
            );



           tvList.add(playlistsModel);
            tvPlayLists.add(playlistsNameModel);

          });
          print(tvList.length);
          print(tvPlayLists[0].playlistName! + "playlistss");
          print(tvPlayLists[0].data!.length.toString()+ "playlistss");


          // print(tvList);
          // print(
          //     'Title: ${entry.title} Link: ${entry.link} Logo: ${entry.attributes['tvg-logo']}');
        }
        setState((){
          processing =false;
        });

        setState(() {
          error = false;
        });
      }
      else{
        setState(() {
          error = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        error = true;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    print(widget.urlText);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          processing == false
              ? Container(
                  height: size.height,
                  width: size.width * 0.5,
                  color: HexColor("#394a52"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.download,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Processing",
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ))
                    ],
                  ),
                )
              : error == true
                  ? Container(
                      height: size.height,
                      width: size.width * 0.5,
                      color: HexColor("#394a52"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.download,
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                              child: const Text(
                                "Please Check Your url and Internet",
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              )
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: size.height,
                      width: size.width * 0.5,
                      color: HexColor("#394a52"),
                      child: FadeTransition(
                        opacity: _animation!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.download,
                              size: 50,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Processing",
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ),
          Container(
            height: size.height,
            width: size.width * 0.3,
            color: HexColor("#2b383e"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: const Text(
                    "Playlist Name",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(

                  children: tvPlayList.map((e) {
                    return Expanded(
                      child: RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          value: e,
                          title: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                          groupValue: selectedTvPlayList,
                          onChanged: (value) {
                            setState(() => {
                                  selectedTvPlayList = value!,
                                });
                          }),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Container(
            height: size.height,
            width: size.width * 0.2,
            color: HexColor("#1c252a"),
            child: Container(
              margin: const EdgeInsets.only(left: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      processing ==false
                          ? TextButton(
                              onPressed: () async{
                                await PlaylistDatabase.savePlaylist(tvPlayLists, widget.playListsTitle);
                               await PlaylistDatabase.getPlaylist();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayList(
                                              tvList: tvList,
                                            )));
                              },
                              child: const Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ))
                          : TextButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayList(tvList: tvList,)));
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(color: HexColor("#4d5558")),
                              )),
                      tvList.isNotEmpty
                          ? const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: HexColor("#4d5558"),
                            ),
                    ],
                  )),
                  Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: HexColor("4d5558")),
                          )),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
