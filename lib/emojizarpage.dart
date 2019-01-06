import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage2.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Emojizar extends StatefulWidget {

  Emojizar({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _EmojizarState createState() => _EmojizarState();
}

class _EmojizarState extends State<Emojizar> {

  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();
  String error;

  double lat,long;

  void initState(){
    super.initState();
    currentLocation['Latitude'] = 0.0;
    currentLocation['Longitude'] = 0.0;

    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result) {
      setState(() {
        currentLocation = result;
      });
    });
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
      lat=currentLocation['latitude'];
      long=currentLocation['longitude'];

    });
  }

  @override
  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;
  int bgPurple = 0xFFC7B8E4;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body:  Container(
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Image.asset('design/ucabista.png', width: 230.0, height: 286.0,),
                      new InkWell(
                          onTap: () {
                            print(lat);
                            print(long);
                            print('Lat/Long:${currentLocation['latitude']}/${currentLocation['longitude']}');
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => new Camara(onSignedOut: widget.onSignedOut,)));
                          },
                          child: new Container(
                              width: 200.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  color: Colors.green,
                                  border: new Border.all(color: Colors.white, width: 1.5),
                                  borderRadius: new BorderRadius.circular(10.0)),
                              child: new Center(
                                  child: new Text('EMOJIZAR',
                                      style: new TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white)))))]))));
  }

}