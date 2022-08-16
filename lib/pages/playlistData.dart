

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/db/local_db.dart';

class PlaylistData extends StatefulWidget {
  const PlaylistData({Key? key}) : super(key: key);

  @override
  State<PlaylistData> createState() => _PlaylistDataState();
}

class _PlaylistDataState extends State<PlaylistData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DBProvider.db.getDataFromDb(context, ""),
        builder: (context, ss){
          switch(ss.connectionState){
            case ConnectionState.waiting:
              return Text("wait");

            case ConnectionState.done:
            default:
              if(ss.hasError){
                return Text(ss.error.toString());

              }
              else if(ss.hasData){
                var data = ss.data;
                return ListView(
                  shrinkWrap: true,
                  primary: false,

                  children:(data as List<String>).map((list){

                    return list != "android_metadata" && list != "sqlite_sequence"?
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaylistData()));
                      },
                      child: Container(
                        child: Text(list),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(15),
                        color: Colors.green[100],
                      ),
                    ): SizedBox();
                  }).toList(),
                );


              }
              else {
                return Text("no data", style: TextStyle(color: Colors.white),);
              }

          }
        },
      ),
    );
  }
}
