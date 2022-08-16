

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task1/model/PlaylistNameModel.dart';
import 'package:task1/model/playlistmodel.dart';
import 'package:task1/pages/playlist.dart';
import 'package:task1/provider/iptvProvider.dart';

class DBProvider {
  static Database? _database;
  String? name;
  String playlistName = "playlistNameTable";
  String playlists = "playlistTable";

  ipTvProvider ip = ipTvProvider();
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    // If database exists, return database
    //if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'playlists.db');

    return await openDatabase(path, version: 3, onOpen: (db) {

    },
        onCreate: (Database db, int version) async {

          await db.execute('CREATE TABLE $playlistName (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,playlistName TEXT)' );

          await db.execute('''
        CREATE TABLE $playlists (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,playlistName TEXT, link TEXT, title TEXT, logo TEXT)
          ''');


        });
  }

  // Insert employee on database

  // createPlaylist(PlaylistsModel playlistsModel, String name) async {
  //   //await deletePlayList(name);
  //   final db = await _database;
  //   final res = await db!.insert("playlists", playlistsModel.toJson());
  //   print(res);
  //
  //   return res;
  // }
  insertPlayListName(List<PlaylistsNameModel> products,String name )async{
    ip.tvPlayLists.clear();

    //await _database?.delete(playlistName);

    for(var element in  products) {
      // ipTvProvider.tvPlayLists.add(singleProductModelFromJson(
      //     json.encode(element)));
      ip.tvPlayLists.add(element);
      await _database!.transaction((txn) async {
        //var searchText=element.name?.toLowerCase();
        // var productData= json.encode(element);
        await txn.insert(
          playlistName,
          {
            "id": element.id,
            "playlistName": element.playlistName,
          }
          ,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    }
  }
  insertAllPlayList(List<PlaylistsModel> products,String name )async{
    ip.tvList.clear();

    //await _database?.delete(playlists);

    for(var element in  products) {
      // ipTvProvider.tvPlayLists.add(singleProductModelFromJson(
      //     json.encode(element)));
      ip.tvList.add(element);
      await _database!.transaction((txn) async {
        //var searchText=element.name?.toLowerCase();
       // var productData= json.encode(element);
        await txn.insert(
          playlists,
          {
            "title": element.title,
            "link": element.link,
            "logo": element.logo,
            "playlistName": element.playlistName!
          }
          ,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    }
  }

  Future<List<PlaylistsNameModel>> getPlayListNameFromDb(BuildContext context) async {
    if (_database != null) {
      List<Map> maps =
      await _database!.rawQuery('SELECT * FROM $playlistName ;');

      List<PlaylistsNameModel> tableNameList = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          try {
            PlaylistsNameModel playlistsModel = PlaylistsNameModel(
                id: maps[i]['id'],
                playlistName: maps[i]['playlistName'].toString()
            );
            tableNameList.add(playlistsModel);

          } catch (e) {
            print('Exeption : ' + e.toString());
          }
        }

        //Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayList(tvList:tableNameList,)));
      }
      return tableNameList;

    }
    else{
      List<PlaylistsNameModel> tableNameList = [];
      return tableNameList;
    }
  }

  Future<List<PlaylistsModel>> getDataFromDb(BuildContext context, String name) async {
    if (_database != null) {
      List<Map> maps =
      await _database!.rawQuery('SELECT * FROM $playlists WHERE playlistName=?', [name]);

      List<PlaylistsModel> tableNameList = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          try {
            PlaylistsModel playlistsModel = PlaylistsModel(
              id: maps[i]['id'],

              title: maps[i]['title'].toString(),
              link: maps[i]['link'].toString(),
              logo: maps[i]['logo'].toString(),
              playlistName: maps[i]['playlistName'].toString()
            );
            tableNameList.add(playlistsModel);

          } catch (e) {
            print('Exeption : ' + e.toString());
          }
        }

        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayList(tvList:tableNameList,)));
      }
      return tableNameList;

    }
    else{
      List<PlaylistsModel> tableNameList = [];
      return tableNameList;
    }
  }



  // Delete all employees
  Future<int> deletePlayList(String name) async {
    final db = await _database;
    final res = db!.rawDelete('DELETE FROM $playlists WHERE playlistName = ?', [name]);
    final res1 = db.rawDelete('DELETE FROM $playlistName WHERE playlistName = ?', [name]);
    await getAllTableNames();
    return res;
  }
   List? table;
  Future<List<String>> streamTable(
      {Duration? refreshTime}) async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
       await getAllTableNames();
    }
  }
  List<PlaylistsNameModel> newTableNameList = [];
  Future<List<PlaylistsNameModel>> getAllTableNames() async {
// you can use your initial name for dbClient
    if (_database != null) {
      List<Map> maps =
      await _database!.rawQuery('SELECT * FROM $playlistName ORDER BY playlistName;');


      if (maps.length > 0) {
        newTableNameList.clear();
        for (int i = 0; i < maps.length; i++) {
          try {
            PlaylistsNameModel playlistsNameModel = PlaylistsNameModel(
              playlistName: maps[i]['playlistName'].toString()
            );

            newTableNameList.add(playlistsNameModel);
          } catch (e) {
            print('Exeption : ' + e.toString());
          }
        }
      }
      return newTableNameList;

    }
    else{
      newTableNameList = [];
      return newTableNameList;
    }

  }









  }

