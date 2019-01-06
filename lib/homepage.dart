import 'dart:async';

import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ucabmoji/emojizarpage.dart';
import 'package:flutter_ucabmoji/location.dart';
import 'package:flutter_ucabmoji/showdatapage.dart';
import 'package:location/location.dart';

import 'profilepage.dart';
import 'dashboard.dart';
import 'chatpage.dart';
import 'groups.dart';

class HomePage extends StatefulWidget {

  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState(onSignedOut: onSignedOut);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  _HomePageState({this.onSignedOut});
  final VoidCallback onSignedOut;

  TabController tabController;

  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();
  String error;

  void initState(){
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
    currentLocation['Latitude'] = 0.0;
    currentLocation['Longitude'] = 0.0;

    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result) {
      setState(() {
        currentLocation = result;
      });
    });
    print('Lat/Long:${currentLocation['latitude']}/${currentLocation['longitude']}');
  }

  void initPlatformState() async{
    Map<String,double> my_location;
    try{
      my_location = await location.getLocation();
      error="";
    }on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED')
        error = "Permission Denied";
      else if(e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error = "Permission Denied - Please ask the user to eneable it from the app settings";
      my_location = null;
    }
    setState(() {
      currentLocation = my_location;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      bottomNavigationBar: new Material(
        color: Colors.white,
        //color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.home,color: Theme.of(context).primaryColor)),
            new Tab(icon: Icon(Icons.chat,color: Theme.of(context).primaryColor)),
            new Tab(icon: Icon(Icons.camera,color: Theme.of(context).primaryColor)),
            new Tab(icon: Icon(Icons.my_location,color: Theme.of(context).primaryColor)),
            new Tab(icon: Icon(Icons.person,color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          new ShowDataPage(),
          new ChatPage(),
          new Emojizar(onSignedOut: widget.onSignedOut,),
          new MyLocation(),
          new ProfilePage(onSignedOut: widget.onSignedOut)
        ],
      ),
        );
  }

}
