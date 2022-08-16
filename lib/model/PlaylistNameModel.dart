import 'dart:convert';

List<PlaylistsNameModel> playlistsNameModelFromJson(String str) => List<PlaylistsNameModel>.from(json.decode(str).map((x) => PlaylistsNameModel.fromJson(x)));

String playlistsNameModelToJson(List<PlaylistsNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistsNameModel {
  PlaylistsNameModel({
    this.id,
    this.playlistName,
  });

  int? id;
  String? playlistName;

  factory PlaylistsNameModel.fromJson(Map<String, dynamic> json) => PlaylistsNameModel(
    id: json["id"],
    playlistName: json["playlistName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "playlistName": playlistName,
  };
}
