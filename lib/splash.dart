import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/rootpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  //FUNCION QUE CALCULA EL TIEMPO DE LA PANTALLA SPLASH-------------------------
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new RootPage(auth: new Auth()))));

  }

  //PANTALLA SPLASH-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: Colors.white)),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('design/ucabista.png',scale: 3),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10.0)),
                                 ]))),
                    ])]));
  }

}
