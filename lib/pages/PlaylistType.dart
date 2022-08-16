
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'm3uplaylist.dart';
class PlayListType extends StatefulWidget {
  const PlayListType({Key? key}) : super(key: key);

  @override
  State<PlayListType> createState() => _PlayListTypeState();
}

class _PlayListTypeState extends State<PlayListType> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
body: Row(
  children: [
    Container(
      height:size.height,
      width: size.width *0.5,
      color: HexColor("#394a52"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          const Icon(Icons.list_alt, size: 50,color: Colors.white,),
          const SizedBox(width: 15.0,),
          const Text("PlayList Type", style: const TextStyle(fontSize: 24, color: Colors.white),)
        ],
      ),
    ),
    Container(
      height:size.height,
      width: size.width *0.3,
      color: HexColor("#2b383e"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const M3UPlayList()));
          }, child: const Text("M3U Playlist", style: TextStyle(color: Colors.white),),),
        ],
      ),
    ),
    Container(
      height:size.height,
      width: size.width *0.2,
      color: HexColor("#1c252a"),
      child:  Center(child: TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: const Text("Cancel", style: TextStyle(color: Colors.white),),)),
    ),
  ],
),
    );
  }
}
