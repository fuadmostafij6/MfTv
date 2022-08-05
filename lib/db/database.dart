
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/PlaylistNameModel.dart';

class PlaylistDatabase{
  //static List<PlaylistsNameModel>? playlist;
 static final prefsMap = Map<String, dynamic>();
  static Future savePlaylist(List data, String name) async{
    final pref = await SharedPreferences.getInstance();
    var saveData = jsonEncode(data);
    await pref.setString("$name",saveData );
  }

  static Future<void> getPlaylist()async{
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();


    List<PlaylistsNameModel> p = [];
    // for(String key in keys) {
    //   prefsMap[key] = prefs.get(key);
    //   // Datum datum = Datum(
    //   //   title:  prefsMap[key]
    //   //
    //   // );
    //   //
    //   // PlaylistsNameModel playlistsNameModel = PlaylistsNameModel(
    //   //   playlistName: prefsMap[key],
    //   //   data:
    //   // );
    //
    //
    //
    // }
    // final pref = await SharedPreferences.getInstance();
    // var temp = pref.getString("playList")??{};
    // print("Data recived $temp");
    // var data = PlaylistsNameModel.fromJson(jsonDecode(temp.toString()));
    // print(data.data.toString() + "data");
    // playlist;
    // print(playlist);
    SharedPreferences.getInstance().then((data){
      data.getKeys().forEach((key){
        print(key+"="+data.get(key).toString());
      });
    });


   // print("All" + prefsMap.length.toString() );

  }
}