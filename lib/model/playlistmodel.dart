// To parse this JSON data, do
//
//     final playlistsModel = playlistsModelFromJson(jsonString);

import 'dart:convert';

List<PlaylistsModel> playlistsModelFromJson(String str) => List<PlaylistsModel>.from(json.decode(str).map((x) => PlaylistsModel.fromJson(x)));

String playlistsModelToJson(List<PlaylistsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistsModel {
  PlaylistsModel({
    this.title,
    this.link,
    this.logo,
    this.playlistName,
  });

  String? title;
  String? link;
  String? logo;
  String? playlistName;

  factory PlaylistsModel.fromJson(Map<String, dynamic> json) => PlaylistsModel(
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
