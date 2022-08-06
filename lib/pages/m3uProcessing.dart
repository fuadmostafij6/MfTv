import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

import 'package:task1/pages/playlist.dart';
import 'package:http/http.dart' as http;
import '../db/database.dart';
import '../db/local_db.dart';
import '../model/PlaylistNameModel.dart';
import '../model/playlistmodel.dart';
import '../provider/iptvProvider.dart';

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
  bool processing = true;
  AnimationController? _controller;
  Animation<double>? _animation;
  PlaylistsModel? playlistsModel;
  ipTvProvider ip = ipTvProvider();
  @override
  void initState() {
    DBProvider.db.setName(widget.playListsTitle);
    DBProvider.db.open();

    ip.loadM3U(link: widget.urlText, playListName: widget.playListsTitle).then((value){

      if(ip.tvList.isNotEmpty){

        setState((){
          processing = false;
          error = false;
        });

      }
      else{
        setState((){
          processing = false;

          error = true;
        });
      }
    });
    print(ip.tvList.toString() + "________________eqeqe");

    //loadM3U();
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





  @override
  Widget build(BuildContext context) {
    print(widget.urlText);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
         processing
              ?Container(
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
                  :   Container(
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
                      error ==false && processing== false
                          ? TextButton(
                              onPressed: () async{
                              DBProvider.db.createPlaylist(ip.playlistsModel!, widget.playListsTitle);
                              DBProvider.db.insertAllPlayList(ip.tvList, widget.playListsTitle);
                              DBProvider.db.listTables();




                              // print("____Processs" + tvList.toString());


                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => PlayList(
                                //               tvList: ip.tvList,
                                //             )));
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
                      ip.tvList.isNotEmpty
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
