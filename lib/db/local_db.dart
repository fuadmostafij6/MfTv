

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task1/model/PlaylistNameModel.dart';
import 'package:task1/model/playlistmodel.dart';
import 'package:task1/provider/iptvProvider.dart';

class DBProvider {
  static Database? _database;
  String? name;
  ipTvProvider ip = ipTvProvider();
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'playlist1.db');
    _database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table playlists ( 
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,playlistName TEXT, link TEXT, title TEXT, logo TEXT)
''');
        });
  }
  // Future<Database> get database async {
  //   // If database exists, return database
  //   if (_database != null) return _database!;
  //
  //   // If database don't exists, create one
  //   _database = await initDB();
  //
  //   return _database!;
  // }
  //
  // // Create the database and the Employee table
  // initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   final path = join(documentsDirectory.path, 'playlists.db');
  //
  //   return await openDatabase(path, version: 1, onOpen: (db) {
  //
  //   },
  //       onCreate: (Database db, int version) async {
  //         // await db.execute('CREATE TABLE playlists('
  //         //     'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
  //         //     'playlistName TEXT,'
  //         //     'link TEXT,'
  //         //     'title TEXT,'
  //         //     'logo TEXT,'
  //         //
  //         //     ')');
  //         await db.execute('''
  //       CREATE TABLE $name (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,playlistName TEXT, link TEXT, title TEXT, logo TEXT )
  //         ''');
  //         print("_____dbname1"+ name!);
  //       });
  // }

  // Insert employee on database

  setName(String dbName){
    name = dbName;
    print("_____dbname"+ name!);
  }
  createPlaylist(PlaylistsModel playlistsModel, String name) async {
    //await deletePlayList(name);
    final db = await _database;
    final res = await db!.insert(name, playlistsModel.toJson());

    return res;
  }

  insertAllPlayList(List<PlaylistsModel> products,String name )async{

    await _database?.delete("playlists");

    for(var element in  products) {
      // ipTvProvider.tvPlayLists.add(singleProductModelFromJson(
      //     json.encode(element)));
      ip.tvList.add(element);
      await _database!.transaction((txn) async {
        //var searchText=element.name?.toLowerCase();
       // var productData= json.encode(element);
        await txn.insert(
          "playlists",
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

  // Delete all employees
  Future<int> deletePlayList(String name) async {
    final db = await _database;
    final res = await db!.rawDelete('DELETE FROM playlists');

    return res;
  }
 Future listTables() async {
    final db = await _database;

    // var tableNames = (await db
    //     .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
    //     .map((row) => row['name'] as String)
    //     .toList(growable: false);

    (await db!.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
  }
  // Future<List<PlaylistsModel>> getAllPlaylist() async {
  //   final db = await database;
  //   final res = await db.rawQuery("SELECT * FROM playlists");
  //
  //   List<PlaylistsModel> list =
  //   res.isNotEmpty ? res.map((c) => PlaylistsModel.fromJson(c)).toList() : [];
  //
  //   print(list.toString() + "get database______");
  //
  //   return list;
  // }
}