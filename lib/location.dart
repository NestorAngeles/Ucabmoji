import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/ajustes.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => new _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {

  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();
  String error;
  String lugar;
  double lat,long;
  bool enLaUCAB;

  getLugar(){

    //UCAB
    if((lat<8.298796 && lat>8.295516) && (long< -62.709837 && long> -62.713232)) {
      print("estas en la uni");
      lugar = "UCAB";

      //Canchas
      if((lat<8.298807 && lat>8.297636) && (long> -62.711683 && long< -62.709460)) {
        print("canchas");
        lugar = "canchas";
      }

      //Caja negra
      if((lat<8.297299 && lat>8.297131) && (long> -62.710767 && long< -62.710524)) {
        print("caja negra");
        lugar = "caja negra";
      }

      //patos
      if((lat<8.296998 && lat>8.296583) && (long> -62.711860 && long< -62.711297)) {
        print("Los patos");
        lugar = "los patos";
      }

      //Casa del estudiante
      if((lat<8.296849 && lat>8.296502) && (long> -62.712262 && long< -62.711873)) {
        print("Casa del estudiante");
        lugar = "Casa del estudiante";
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
        lugar = "Escuelas";
      }

      //Parada
      if((lat<8.296980 && lat>8.295850) && (long> -62.713218 && long< -62.712613)) {
        print("Parada");
        lugar = "Parada";
      }

      //Patio central
      if((lat<8.297471 && lat>8.296998) && (long> -62.712452 && long< -62.711454)) {
        print("Patio central");
        lugar = "Patio central";
      }

      //Estacionamiento
      if((lat<8.297636 && lat>8.296836) && (long> -62.711297 && long< -62.710767)) {
        print("Estacionamiento");
        lugar = "Estacionamiento";
      }

      enLaUCAB=true;
    }else {
      print("No estas en la Uni");
      lugar = "";
      enLaUCAB = false;
    }
  }


  void initState(){
    super.initState();
    currentLocation['Latitude'] = 0.0;
    currentLocation['Longitude'] = 0.0;

    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result) {
      setState(() {

        currentLocation = result;
        lat= currentLocation['latitude'];
        long = currentLocation['longitude'];
        getLugar();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Ubicacion"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Ajustes()));
                }
            ),]),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("$lugar"),
                Text('Lat/Long:${lat}/${long}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepPurpleAccent,
                  ),),
              ]
          ),
        )


    );
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
}
