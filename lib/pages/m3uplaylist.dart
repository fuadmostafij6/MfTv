import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'm3uProcessing.dart';

class M3UPlayList extends StatefulWidget {
  const M3UPlayList({Key? key}) : super(key: key);

  @override
  State<M3UPlayList> createState() => _M3UPlayListState();
}

class _M3UPlayListState extends State<M3UPlayList> {
  final urlController = TextEditingController();
  final titleController = TextEditingController();
  String urlText = "";
  String playText = "";
  bool clickUrl = false;



  @override
  Widget build(BuildContext context) {
    print(urlController.text);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: size.height,
            width: size.width * 0.5,
            color: HexColor("#394a52"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.link,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "M3U PlayList",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ))
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width * 0.3,
              color: HexColor("#2b383e"),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              clickUrl = true;
                            });
                          },
                          child: const Text(
                            "Enter Url",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        clickUrl == true
                            ? Column(
                          children: [
                            SizedBox(
                                height: 3 * 24,
                                width: size.width * 0.2,
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() => {urlText = val});
                                  },
                                  maxLines: 3,
                                  minLines: 1,
                                  style: const TextStyle(color: Colors.white),
                                  controller: urlController,
                                  decoration: const InputDecoration(
                                    hintText: "https://....m3u",
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                )),
                            SizedBox(
                                height: 3 * 24,
                                width: size.width * 0.2,
                                child: TextFormField(
                                  onChanged: (val) {
setState((){
  playText =val;
});
                                  },
                                  maxLines: 3,
                                  minLines: 1,
                                  style: const TextStyle(color: Colors.white),
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    hintText: "Play List Name",
                                    hintStyle: TextStyle(
                                      color: Colors.grey
                                    ),
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                ))
                          ],
                        )
                            : const SizedBox(),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(
              height: size.height,
              width: size.width * 0.2,
              color: HexColor("#1c252a"),
              child: Container(
                margin: const EdgeInsets.only(left: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child:  urlText != "" && playText !=""
                            ?  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               M3uProcessing(urlText: urlText, playListsTitle: playText,)));
                                },
                                child: const Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                )),
                            // : TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       "Next",
                            //       style: TextStyle(color: HexColor("#4d5558")),
                            //     )),
                        // Icon(
                        //   Icons.play_arrow,
                        //   color: Colors.white,
                        // )
                      ],
                    ): Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             M3uProcessing(urlText: urlText,)));
                  },
                  child:  Text(
                    "Next",
                    style: TextStyle(color: HexColor("#82878a")),
                  )),
              // : TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Next",
              //       style: TextStyle(color: HexColor("#4d5558")),
              //     )),
              // Icon(
              //   Icons.play_arrow,
              //   color: HexColor("#82878a"),
              // )
            ],
          )),
                    Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
