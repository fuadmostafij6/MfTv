

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

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
  List<Datum> datum = [];
  PlaylistsModel? playlistsModel;
  PlaylistsModel? get _playlistsModel => playlistsModel;

  Future<void> loadM3U({required String link, required String playListName}) async {
    try {

      final response = await http.get(Uri.parse(link));
      final m3u = await M3uParser.parse(response.body);
      print(response.statusCode.toString()+"dsfas");


      if (response.statusCode == 200) {
        _processing =true;
        notifyListeners();

        for (final entry in m3u) {
          playlistsModel = PlaylistsModel(
              title:  entry.title,
              link: entry.link,
              logo: entry.attributes['tvg-logo'],
              playlistName: playListName
          );
          // PlaylistsModel playlistsModel = PlaylistsModel(
          //     title:  entry.title,
          //     link: entry.link,
          //     logo: entry.attributes['tvg-logo'],
          //     playlistName: playListName
          // );
          Datum datum1 = Datum(
              title:  entry.title,
              link: entry.link,
              logo: entry.attributes['tvg-logo'],
              playlistName: playListName
          );
          datum.add(datum1);


          PlaylistsNameModel playlistsNameModel = PlaylistsNameModel(
              data:datum ,
              playlistName: playListName
          );



          tvList.add(playlistsModel!);
          tvPlayLists.add(playlistsNameModel);
          print(tvList.length);
          print(tvPlayLists[0].playlistName! + "playlistss");
          print(tvPlayLists[0].data!.length.toString()+ "playlistss");

          notifyListeners();
          // print(tvList);
          // print(
          //     'Title: ${entry.title} Link: ${entry.link} Logo: ${entry.attributes['tvg-logo']}');
        }
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

  void initialValues(){
    _error = false;
    _errorMessage = "";
    _processing = true;
    _map ={};
    notifyListeners();
  }

}