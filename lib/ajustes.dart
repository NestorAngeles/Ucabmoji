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
        body: ListView(
          children: <Widget>[
            InkWell(
              child: Card(
                child:
                    Container(
                      height:60,
                      child:Center(
                        child:
                Text("Acerca de",style: TextStyle(fontSize: 20),),
              ),))
            ),
            InkWell(
                child: Card(
                    child:
                    Container(
                      height:60,
                      child:Center(
                        child:
                        Text("Tutorial",style: TextStyle(fontSize: 20),),
                      ),))
            ),
          ],
        )
        );

  }
}