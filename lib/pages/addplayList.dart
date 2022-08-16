import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:task1/db/local_db.dart';
import 'package:task1/model/PlaylistNameModel.dart';
import 'package:task1/pages/playlist.dart';
import 'package:task1/pages/playlistData.dart';
import 'package:task1/provider/iptvProvider.dart';

import '../db/database.dart';
import '../widget/customControl.dart';
import 'Drawers/Drawers.dart';
import 'PlaylistType.dart';

class AddPlayList extends StatefulWidget {
  const AddPlayList({Key? key}) : super(key: key);

  @override
  State<AddPlayList> createState() => _AddPlayListState();
}

class _AddPlayListState extends State<AddPlayList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  ipTvProvider ip = ipTvProvider();
  Future<List<PlaylistsNameModel>>?getTableNames;
  List<PlaylistsNameModel> tableName = [];
  int drawerNo = 0;
  String version = "";
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }
FocusNode? focusNode1;
FocusNode? focusNode2;

_setFocus(BuildContext context){
if (focusNode1 == null){
  focusNode1 = FocusNode();
  focusNode2 = FocusNode();
  FocusScope.of(context).requestFocus(focusNode1);
}

}
_changeFocus(BuildContext context, FocusNode node){
  FocusScope.of(context).requestFocus(node);
}
  @override
  void initState() {
    _initPackageInfo();

    setState((){

      DBProvider.db.streamTable();
      tableName = DBProvider.db.newTableNameList;
    });


    super.initState();

  }
  @override
  void dispose(){
  focusNode1!.dispose();
  focusNode2!.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {


setState((){

 DBProvider.db.streamTable();
  tableName = DBProvider.db.newTableNameList;
});
    Size size = MediaQuery.of(context).size;

    // if(focusNode1==null){
    //   _setFocus(context);
    // }
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      key: _scaffoldKey,
      backgroundColor: HexColor("#1e1e1e"),
      endDrawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          child: drawerNo == 0
              ? Drawer(
                  backgroundColor: HexColor("#2b383e"),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: HexColor("#394a53"),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              InkWell(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      drawerNo = 1;
                                    });
                                  },
                                  title: Text(
                                    "General",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ), //1
                              InkWell(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      drawerNo = 2;
                                    });
                                  },
                                  title: Text(
                                    "PlayLists",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ), //2

                              InkWell(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      drawerNo = 9;
                                    });
                                  },
                                  //leading: Icon(Icons.key, color: Colors.white,size: 30,),
                                  title: Text(
                                    "About",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ), //9
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : drawerNo == 1
                  ? WillPopScope(
                      onWillPop: () async {
                        setState(() {
                          drawerNo = 0;
                        });
                        return false;
                      },
                      child: Drawer(
                        backgroundColor: HexColor("#2b383e"),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                color: HexColor("#394a53"),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "General",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [

                                    ListTile(

                                      trailing: Transform.scale(
                                          scale: 1,
                                          child: Switch(
                                            value: true,
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.blueGrey,
                                            inactiveThumbColor: Colors.grey,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            onChanged: (bool value) {},
                                          )),
                                      title: Text(
                                        "Auto start on app boot",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    ListTile(

                                      trailing: Transform.scale(
                                          scale: 1,
                                          child: Switch(
                                            value: true,
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.blueGrey,
                                            inactiveThumbColor: Colors.grey,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            onChanged: (bool value) {},
                                          )),
                                      title: Text(
                                        "Auto start on wakeup from sleep mode",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "May not work all devices",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    ListTile(

                                      trailing: Transform.scale(
                                          scale: 1,
                                          child: Switch(
                                            value: true,
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.blueGrey,
                                            inactiveThumbColor: Colors.grey,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            onChanged: (bool value) {},
                                          )),

                                      title: Text(
                                        "Turn on last channel cn app start",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      //subtitle: Text("May not work all devices", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                    ),
                                    ListTile(

                                      trailing: Transform.scale(
                                          scale: 1,
                                          child: Switch(
                                            value: true,
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.blueGrey,
                                            inactiveThumbColor: Colors.grey,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            onChanged: (bool value) {},
                                          )),

                                      title: Text(
                                        "Confirm Exit by second press back",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      //subtitle: Text("May not work all devices", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                    ),
                                    ListTile(

                                      // trailing: Transform.scale(
                                      //     scale: 1,
                                      //     child: Switch(
                                      //
                                      //       value: false,
                                      //       activeColor: Colors.blue,
                                      //       activeTrackColor: Colors.yellow,
                                      //       inactiveThumbColor: Colors.grey,
                                      //       inactiveTrackColor: Colors.grey.shade400, onChanged: (bool value) {  },
                                      //     )
                                      // ),

                                      title: Text(
                                        "User-Agent",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Not set",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    ListTile(

                                      // trailing: Transform.scale(
                                      //     scale: 1,
                                      //     child: Switch(
                                      //
                                      //       value: false,
                                      //       activeColor: Colors.blue,
                                      //       activeTrackColor: Colors.yellow,
                                      //       inactiveThumbColor: Colors.grey,
                                      //       inactiveTrackColor: Colors.grey.shade400, onChanged: (bool value) {  },
                                      //     )
                                      // ),

                                      title: Text(
                                        "UDP proxy (address:port)",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Not set",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    ListTile(

                                      // trailing: Transform.scale(
                                      //     scale: 1,
                                      //     child: Switch(
                                      //
                                      //       value: false,
                                      //       activeColor: Colors.blue,
                                      //       activeTrackColor: Colors.yellow,
                                      //       inactiveThumbColor: Colors.grey,
                                      //       inactiveTrackColor: Colors.grey.shade400, onChanged: (bool value) {  },
                                      //     )
                                      // ),

                                      title: Text(
                                        "Backup data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      //subtitle: Text("Not set", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                    ),
                                    ListTile(

                                      // trailing: Transform.scale(
                                      //     scale: 1,
                                      //     child: Switch(
                                      //
                                      //       value: false,
                                      //       activeColor: Colors.blue,
                                      //       activeTrackColor: Colors.yellow,
                                      //       inactiveThumbColor: Colors.grey,
                                      //       inactiveTrackColor: Colors.grey.shade400, onChanged: (bool value) {  },
                                      //     )
                                      // ),

                                      title: Text(
                                        "Restore data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      //subtitle: Text("Not set", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : drawerNo == 2


                      ?
          WillPopScope(
                          onWillPop: () async {
                            setState(() {
                              drawerNo = 0;
                            });
                            return false;
                          },
                          child: RefreshIndicator(
                            key: _refreshIndicatorKey,
                            onRefresh: ()async{
                              await DBProvider.db.getAllTableNames();
                              tableName = DBProvider.db.newTableNameList;

                            },
                            child: Drawer(
                              backgroundColor: HexColor("#2b383e"),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      color: HexColor("#394a53"),
                                      height: MediaQuery.of(context).size.height *
                                          0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "PlayList",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  tableName.length >0?
                                  ListView.builder(
                                    itemCount: tableName.length >0?tableName.length:0,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      tableName = DBProvider.db.newTableNameList;
                                     var data = tableName[index];


                                      return tableName.length >0?
                                      ListTile(
                                        onTap: (){
                                          DBProvider.db.getDataFromDb(context, data.playlistName!);
                                        },
                                        trailing: IconButton(
                                          icon: Icon(Icons.remove_circle_outlined), onPressed: () {
                                            DBProvider.db.deletePlayList(data.playlistName!).then((value){

                                              // _refreshIndicatorKey.currentState!.show();
                                              if(DBProvider.db.newTableNameList.isEmpty){
                                                tableName.clear();
                                              }
                                              else{
                                                tableName.remove(data.playlistName);
                                              }
                                            });
                                        },
                                        ),
                                        title: Text(data.playlistName!.toUpperCase(), style: TextStyle(color: Colors.white),),
                                      )
                                          :  SizedBox(
                                        child: Text("There is no playlist"),
                                      );
                                  },

                                  ):
                                  SizedBox(
                                    child: Text("There is no playlist"),
                                  ),

                                    TextButton(onPressed: (){
                                      setState(() {
                                        drawerNo = 0;
                                      });
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayListType() ));
                                    }, child: Text("Add playlist"))

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):

                       drawerNo == 9
                          ? WillPopScope(
                              onWillPop: () async {
                                setState(() {
                                  drawerNo = 0;
                                });
                                return false;
                              },
                              child: Drawer(
                                backgroundColor: HexColor("#2b383e"),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: HexColor("#394a53"),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            "About",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.85,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            ListTile(
                                              // leading: Icon(Icons.lock, color: Colors.grey,),
                                              trailing: Transform.scale(
                                                  scale: 1,
                                                  child: Switch(
                                                    value: true,
                                                    activeColor: Colors.blue,
                                                    activeTrackColor:
                                                        Colors.blueGrey,
                                                    inactiveThumbColor:
                                                        Colors.grey,
                                                    inactiveTrackColor:
                                                        Colors.grey.shade400,
                                                    onChanged: (bool value) {},
                                                  )),

                                              title: Text(
                                                "Send anonymous statistics to improve the app",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              //subtitle: Text("By Name", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                            ),
                                            ListTile(
                                              // leading: Icon(Icons.lock, color: Colors.grey,),

                                              title: Text(
                                                "Privacy policy",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              // subtitle: Text("May not work all devices", style: TextStyle(color: Colors.grey, fontSize: 10, ),),
                                            ),
                                            ListTile(

                                              title: Text(
                                                "Version",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              subtitle: Text(
                                                version,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Drawer(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                height: size.height * 0.1,
                width: size.width * 0.85,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    )),
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "Mftv Player app doesn't provide any source of TV channels! you need to add the playlist from your IPTV provide to be able to watch TV channels",
                    style: TextStyle(color: Colors.white),
                  ),
                ))),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.arrowLeft):LeftButtonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowRight):RightButtonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowUp):UpButtonIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowDown):DownButtonIntent(),
              LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Actions(

                  actions:<Type,Action<Intent>> {


                  },
                  child: Focus(
                    focusNode: focusNode1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PlayListType()));
                      },
                      style:
                          TextButton.styleFrom(


                              backgroundColor: focusNode1!.hasFocus? HexColor("#ffffff"):HexColor("#495154") ),
                      child: Text(
                        "Add PlayList",
                        style: TextStyle(color: focusNode1!.hasFocus?HexColor("#0c0c0c"):HexColor("#ffffff")),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Focus(
                  focusNode: focusNode2,
                  child: TextButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    style:
                        TextButton.styleFrom(backgroundColor: focusNode2!.hasFocus? HexColor("#ffffff"):HexColor("#495154") ),
                    child: Text(
                      "Settings",
                      style: TextStyle(color:focusNode2!.hasFocus?HexColor("#0c0c0c"):HexColor("#ffffff")),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
