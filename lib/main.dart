import 'package:app_profilepage/auth.dart';
import 'package:app_profilepage/rootpage.dart';
import 'package:flutter/material.dart';

//pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';
import 'selectprofpic.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(auth: new Auth()),
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
