import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String error,lugar,error2;
  bool enLaUCAB;
  double lat,long;
  String lat2,long2;

  getLugar(){

    if(lat==null || long==null){
      enLaUCAB =false;
      lugar="";
      error2="Error al obtener su ubicacion";
      return;
    }

    //UCAB
    if((lat<8.298796 && lat>8.295516) && (long< -62.709837 && long> -62.713232)) {
      print("estas en la uni");
      lugar = "UCAB";

      //Canchas
      if((lat<8.298807 && lat>8.297636) && (long> -62.711683 && long< -62.709460)) {
        print("canchas");
        lugar = "Canchas Deportivas";
      }

      //Caja negra
      if((lat<8.297299 && lat>8.297131) && (long> -62.710767 && long< -62.710524)) {
        print("caja negra");
        lugar = "Caja Negra";
      }

      //patos
      if((lat<8.296998 && lat>8.296583) && (long> -62.711860 && long< -62.711297)) {
        print("Los patos");
        lugar = "Los patos / Biblioteca";
      }

      //Casa del estudiante
      if((lat<8.296849 && lat>8.296502) && (long> -62.712262 && long< -62.711873)) {
        print("Casa del estudiante");
        lugar = "Casa del Estudiante";
      }

      //Anfiteatro
      if((lat<8.296502 && lat>8.296215) && (long> -62.712124 && long< -62.711743)) {
        print("Anfiteatro");
        lugar = "Anfiateatro";
      }

      //Modulo 1
      if((lat<8.296931 && lat>8.296497) && (long> -62.710924 && long< -62.710508)) {
        print("Modulo 1");
        lugar = "Modulo 1";
      }

      //Modulo 2
      if((lat<8.296723 && lat>8.296358) && (long> -62.711215 && long< -62.710924)) {
        print("Modulo 2");
        lugar = "Modulo 2";
      }

      //Modulo AR
      if((lat<8.296367 && lat>8.296009) && (long> -62.711494 && long< -62.711215)) {
        print("Modulo AR");
        lugar = "Modulo AR";
      }

      //Modulo 4
      if((lat<8.296189 && lat>8.295772) && (long> -62.711862 && long< -62.711494)) {
        print("Modulo 4");
        lugar = "Modulo 4";
      }

      //Escuelas
      if((lat<8.297242 && lat>8.296053) && (long> -62.712637 && long< -62.712144)) {
        print("Escuelas");
        lugar = "Escuelas / Laboratorios";
      }

      //Parada
      if((lat<8.296980 && lat>8.295850) && (long> -62.713218 && long< -62.712613)) {
        print("Parada");
        lugar = "Parada UCAB";
      }

      //Patio central
      if((lat<8.297471 && lat>8.296998) && (long> -62.712452 && long< -62.711454)) {
        print("Patio central");
        lugar = "Patio Central";
      }

      //Estacionamiento
      if((lat<8.297636 && lat>8.296836) && (long> -62.711297 && long< -62.710767)) {
        print("Estacionamiento");
        lugar = "Estacionamiento";
      }

      enLaUCAB=true;
    }else{
      print("No estas en la Uni");
      lugar = "";
      enLaUCAB = false;
      error2="Debes estar en la UCAB para EMOJIZAR";
    }
    if((lat<8.302044 && lat>8.301336) && (long< -62.732182 && long> -62.733522)) {
      print("Estas en los Raudales");
      lugar = "Los Raudales";
      enLaUCAB=true;
    }
  }


  comprobarCorreo()async{
    List<String> nicks = new List();

    DatabaseReference ref = await FirebaseDatabase.instance.reference();
    ref.child('Post').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      nicks.clear();
      print("Hola");
      for (var key in keys) {
        String d = data['nickName'];
        nicks.add(d);
      }
      print('Length: ${nicks.length}');
    });
  }

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
      lat2=lat.toStringAsFixed(6);
      long2=long.toStringAsFixed(6);
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
                            getLugar();
                            if(enLaUCAB) {
                              comprobarCorreo();
                              print(lat);
                              print(long);
                              print(
                                  'Lat/Long:${currentLocation['latitude']}/${currentLocation['longitude']}');
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) =>
                                  new Camara(onSignedOut: widget.onSignedOut,
                                      lat: lat2,
                                      long: long2,
                                      lugar: lugar)));
                            }else{
                              showToast(error2, false);
                              error="";
                            }
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

  void showToast (String alerta, bool color) {
    String error;

    Color colors;
    if(!color)
      colors = Colors.red;
    else
      colors = Colors.green;

    Fluttertoast.showToast(
        backgroundColor: colors,
        msg: alerta,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        textColor: Colors.white
    );
  }


}