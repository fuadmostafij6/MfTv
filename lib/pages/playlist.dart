import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/playlistmodel.dart';
import 'VideoPlayer.dart';
class PlayList extends StatefulWidget {
  final List <PlaylistsModel>tvList;
  const PlayList({Key? key, required this.tvList}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {

  bool click = false;
  // Future ada(String link)async{
  //
  //   final playList = await HlsPlaylistParser.create()
  //       .parseString(Uri.parse(link), M3u);
  //   playList as HlsMediaPlaylist;
  //
  //   final mediaPlaylistUrls = playList.segments.map((it) => it.url);
  //   final titles = playList.segments.map((it) => it.title);
  //   final fullSegmentEncryptionKeyUri = playList.segments.map((it) => it.fullSegmentEncryptionKeyUri);
  //   final encryptionIV = playList.segments.map((it) => it.encryptionIV);
  //   final byterangeLength = playList.segments.map((it) => it.byterangeLength);
  //   return;
  // }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    print(widget.tvList);
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: widget.tvList.isNotEmpty?ListView.builder(
          itemCount: widget.tvList.length,
          itemBuilder: (context, index){

            return Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.zero,
                    color: HexColor("#2b383e"),
                    width: size.width*0.25,
                    height:click == false?  size.height*0.1: size.height*0.19,
                    child:
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayers(link:"${widget.tvList[index].link}", title: widget.tvList[index].title!, )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                           Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: Text("${index+1}",style:  TextStyle(color: Colors.white),),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                              child: SizedBox(


                                child:
                                Text("${widget.tvList[index].title}",   overflow: TextOverflow.ellipsis,
                                  maxLines: 1,style: const TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    width: size.width*0.75,
                    height:click == false?  size.height*0.1: size.height*0.19,

                    color: HexColor("#1c252a"),

                    child:
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  setState((){
                                    click = !click;
                                  });
                                },
                                child: SizedBox(

                                  child:  Text("No Information", style: TextStyle(color: HexColor("#656d70")),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(

                                child:  Text("No Information", style: TextStyle(color: HexColor("#656d70")),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child:  Text("No Information", style: TextStyle(color: HexColor("#656d70")),),
                              ),
                            ),


                          ],
                        ),
                        click ==true?  Container(
                          height: size.height*0.12,
                          color: HexColor("#1d2f3b"),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                InkWell(
                                  onTap: (){
                                   // Navigator.push(context,MaterialPageRoute(builder: (context)=> VideoPlayers(link:"${widget.tvList[index]["link"]}",)) );
                                  },
                                  child: Column(
                                    children: [
                                      const Text("No information",style: TextStyle(color: Colors.white),),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children:  [
                                          const Text("04:00-05:00",style: TextStyle(color: Colors.white),),
                                          const SizedBox(width: 10,),
                                          Container(
                                            width: 50,
                                            height: 10,
                                            color: Colors.white,
                                            child: const LinearProgressIndicator(
                                              value: 0.25,

                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          const Text("19m",style: TextStyle(color: Colors.white),)

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Icon(Icons.star, color: Colors.white,),
                                    Text("Undefined", style: TextStyle(color: Colors.white),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ): const SizedBox(),
                      ],
                    ),
                  ),
                )

              ],
            );
          }):SizedBox()

    );
  }
}
