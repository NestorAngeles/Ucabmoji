import 'package:flutter/services.dart';
import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/splash.dart';

//pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';
import 'selectprofpic.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new RootPage(auth: new Auth()),
      theme: ThemeData(
          primaryColor: Color(dkPurple),
          accentColor: Color(lgPurple),
      //routes: <String, WidgetBuilder>{
      //  '/landingpage': (BuildContext context) => new MyApp(),
      //  '/signup': (BuildContext context) => new SignupPage(),
      //  '/homepage': (BuildContext context) => new HomePage(),
      //  '/selectpic': (BuildContext context) => new SelectprofilepicPage()
      //},
    ));
  }
}
