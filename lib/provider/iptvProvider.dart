

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

import '../db/local_db.dart';
import '../model/PlaylistNameModel.dart';
import '../model/playlistmodel.dart';

class ipTvProvider with ChangeNotifier{
  Map<String, dynamic> _map ={};
  bool _error = false;
  bool _processing = true;
  bool get processing => _processing;
  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errrMessege => _errorMessage;
  List<PlaylistsModel> tvList = [];
  List<PlaylistsModel>  get _tvList => tvList;
  List<PlaylistsNameModel> tvPlayLists = [];
  List<PlaylistsNameModel> get _tvPlayLists => tvPlayLists;
  PlaylistsModel? playlistsModel;
  PlaylistsNameModel? playlistsNameModel;
  PlaylistsModel? get _playlistsModel => playlistsModel;
  PlaylistsNameModel? get _playlistsNameModel => playlistsNameModel;

  Future<void> loadM3U({required String link, required String playListName}) async {
    try {

      final response = await http.get(Uri.parse(link));
      final m3u = await M3uParser.parse(response.body);
      print(response.statusCode.toString()+"dsfas");


      if (response.statusCode == 200) {
        //_processing =true;
        notifyListeners();

        for (final entry in m3u) {
          playlistsModel = PlaylistsModel(
              title:  entry.title,
              link: entry.link,
              logo: entry.attributes['tvg-logo'],
              playlistName: playListName
          );







          tvList.add(playlistsModel!);

          print(tvList.length);


          notifyListeners();
          // print(tvList);
          // print(
          //     'Title: ${entry.title} Link: ${entry.link} Logo: ${entry.attributes['tvg-logo']}');
        }
        playlistsNameModel = PlaylistsNameModel(
          playlistName: playListName,
        );

        tvPlayLists.add(playlistsNameModel!);
        _processing =false;
        _error = false;
        notifyListeners();

      }
      else{
        _error = true;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print(e);
     _error = true;
      notifyListeners();
    }
  }
 SetDB_DATA( List<PlaylistsModel> tvList1){
    tvList = tvList1;

    print("________"+tvList[0].title.toString());
    notifyListeners();


 }


  void initialValues(){
    _error = false;
    _errorMessage = "";
    _processing = true;
    _map ={};
    notifyListeners();
  }

}