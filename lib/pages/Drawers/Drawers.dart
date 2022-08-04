
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Container(

        width: MediaQuery.of(context).size.width*0.35,
        child: Drawer(
          backgroundColor: HexColor("#2b383e"),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: HexColor("#394a53"),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width*0.35,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text("Settings", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white
                    ),),
                  ),
                ),
                ListView(

                  children: [

                  ],
                )
              ],
            ),
          ),

        ),
    ),
      );
  }
}
