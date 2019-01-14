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
  String lat2,long2;

  String mapa ="design/mapa.png",actual="design/mapa.png";

  getLugar(){
    print("getLugar");

    if(lat==null || long==null){
      actual="design/smile.png";
      enLaUCAB =false;
      lugar="Espere...";
      print("nullllllll");
      return;
    }

    //UCAB
    if((lat<8.298796 && lat>8.295516) && (long< -62.709837 && long> -62.713232)) {
      print("estas en la uni");
      lugar = "UCAB";
      actual=mapa;

      //Canchas
      if((lat<8.298807 && lat>8.297636) && (long> -62.711683 && long< -62.709460)) {
        print("canchas");
        lugar = "Canchas Deportivas";
        actual="design/canchas.png";
      }

      //Caja negra
      if((lat<8.297299 && lat>8.297131) && (long> -62.710767 && long< -62.710524)) {
        print("caja negra");
        lugar = "Caja Negra";
        actual="design/cajaNegra.png";
      }

      //patos
      if((lat<8.296998 && lat>8.296583) && (long> -62.711860 && long< -62.711297)) {
        print("Los patos");
        lugar = "Los Patos / Biblioteca";
        actual="design/patos.png";
      }

      //Casa del estudiante
      if((lat<8.296849 && lat>8.296502) && (long> -62.712262 && long< -62.711873)) {
        print("Casa del estudiante");
        lugar = "Casa del Estudiante";
        actual="design/casaEstudiante.png";
      }

      //Anfiteatro
      if((lat<8.296502 && lat>8.296215) && (long> -62.712124 && long< -62.711743)) {
        print("Anfiteatro");
        lugar = "Anfiateatro";
        actual="design/anfiteatro.png";
      }

      //Modulo 1
      if((lat<8.296931 && lat>8.296497) && (long> -62.710924 && long< -62.710508)) {
        print("Modulo 1");
        lugar = "Modulo 1";
        actual="design/modulo1.png";
      }

      //Modulo 2
      if((lat<8.296723 && lat>8.296358) && (long> -62.711215 && long< -62.710924)) {
        print("Modulo 2");
        lugar = "Modulo 2";
        actual="design/modulo2.png";
      }

      //Modulo AR
      if((lat<8.296367 && lat>8.296009) && (long> -62.711494 && long< -62.711215)) {
        print("Modulo AR");
        lugar = "Modulo AR";
        actual="design/moduloAR.png";
      }

      //Modulo 4
      if((lat<8.296189 && lat>8.295772) && (long> -62.711862 && long< -62.711494)) {
        print("Modulo 4");
        lugar = "Modulo 4";
        actual="design/modulo4.png";
      }

      //Escuelas
      if((lat<8.297242 && lat>8.296053) && (long> -62.712637 && long< -62.712144)) {
        print("Escuelas");
        lugar = "Escuelas";
        actual="design/escuelas.png";
      }

      //Parada
      if((lat<8.296980 && lat>8.295850) && (long> -62.713218 && long< -62.712613)) {
        print("Parada");
        lugar = "Parada UCAB";
        actual="design/parada.png";
      }

      //Patio central
      if((lat<8.297471 && lat>8.296998) && (long> -62.712452 && long< -62.711454)) {
        print("Patio central");
        lugar = "Patio central";
        actual="design/patioCentral.png";
      }

      //Estacionamiento
      if((lat<8.297636 && lat>8.296836) && (long> -62.711297 && long< -62.710767)) {
        print("Estacionamiento");
        lugar = "Estacionamiento";
        actual="design/estacionamiento.png";
      }

      enLaUCAB=true;
    }else {
      print("No estas en la UCAB");
      lugar = "No estas en la UCAB";
      enLaUCAB = false;
      actual="design/sad.png";
    }

    if((lat<8.302044 && lat>8.301336) && (long< -62.732182 && long> -62.733522)) {
      print("Estas en los Raudales");
      lugar = "Los Raudales";
      enLaUCAB=true;
    }

  }


  void initState(){
    super.initState();
    currentLocation['Latitude'] = 0.0;
    currentLocation['Longitude'] = 0.0;
    initPlatformState();
    getLugar();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result) {
      setState(() {
        print("set estate");
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
          automaticallyImplyLeading: false,
          centerTitle: true,
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: Image.asset("design/location.png",scale: 25,)
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,5,5,5),
                        child: Text("$lugar",style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor))),
                    ]),
                Text('Lat/Long:${lat}/${long}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepPurpleAccent,
                  ),),
                Image.asset(actual),
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
      print("ERRORRRRRRRRRRRR");
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
