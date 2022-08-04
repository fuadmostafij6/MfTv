import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1/pages/addplayList.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const Splash());
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  navigateHome()async{
    await Future.delayed(const Duration(seconds: 3), (){

    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddPlayList()));
  }

  @override
  void initState(){
    navigateHome();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration:  const BoxDecoration(
             image: DecorationImage(

                //image: AssetImage("assets/9507F58D-FDEB-440B-8361-1C78BAE3E22B.png"), fit: BoxFit.cover),
                image: AssetImage("assets/BD2525FB-E041-49BD-875D-D6E671E0ED3F.png"), fit: BoxFit.cover),

        ),

      ),
    );
  }
}
