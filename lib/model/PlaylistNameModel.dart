// To parse this JSON data, do
//
//     final playlistsNameModel = playlistsNameModelFromJson(jsonString);

import 'dart:convert';

List<PlaylistsNameModel> playlistsNameModelFromJson(String str) => List<PlaylistsNameModel>.from(json.decode(str).map((x) => PlaylistsNameModel.fromJson(x)));

String playlistsNameModelToJson(List<PlaylistsNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistsNameModel {
  PlaylistsNameModel({
    this.playlistName,
    this.data,
  });

  String? playlistName;
  List<Datum>? data;

  factory PlaylistsNameModel.fromJson(Map<String, dynamic> json) => PlaylistsNameModel(
    playlistName: json["playlistName"],
    data: json["data"]==null?[]:List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "playlistName": playlistName,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.link,
    this.logo,
    this.playlistName,
  });

  String? title;
  String? link;
  String? logo;
  String? playlistName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    link: json["link"],
    logo: json["logo"],
    playlistName: json["playlistName"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "logo": logo,
    "playlistName": playlistName,
  };
}
