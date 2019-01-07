import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {

  final int dkPurple = 0xFF2C1656;

  //PANTALLA DE AJUSTES---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Ajustes"),
            backgroundColor: Color(dkPurple)),
        body: new Center(
            child: new RaisedButton(
                child: new Text("Volver"),
                onPressed: () {
                  Navigator.pop(context);
                }
            )
        )
    );
  }
}