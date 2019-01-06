import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage4.dart';
import 'package:flutter_ucabmoji/homepage.dart';

class CrearPublicacion extends StatefulWidget {

  CrearPublicacion({this.image});

  File image;

  @override
  _CrearPublicacionState createState() => new _CrearPublicacionState();
}


class _CrearPublicacionState extends State<CrearPublicacion> {

  String titulo, comentario;
  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Emojizar"),backgroundColor: Color(dkPurple),),
      body: Container(
        child: Center(
          child: Column(
              children: <Widget>[
                Image.file(widget.image, width: 50,height: 50),
                new TextField(
                  decoration: new InputDecoration(
                      labelStyle: TextStyle(color: Color(dkPurple)),
                      labelText: "Titulo",
                      fillColor: Colors.white,
                      filled: true),
                  //validator: (value) => value.isEmpty ? "Texto vacio" : null,
                  onChanged: (value) => titulo = value,
                ),

                new TextField(
                    decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Color(dkPurple)),
                        labelText: "Comentario",
                        fillColor: Colors.white,
                        filled: true),
                    //validator: (value) => value.isEmpty ? "Texto vacio" : null,
                    onChanged: (value) => comentario = value),
                new SizedBox(height: 15),
                new Text("Ubicacion",style: new TextStyle(fontSize: 30)),
                new Container(
                    padding: EdgeInsets.only(top:20,left: 50,right: 30),
                    child:
                    new Row(
                        children: <Widget>[
                          new Image.asset("design/angry.png",scale: 2,),
                          new SizedBox(width: 10),
                          new Image.asset("design/sad.png",scale: 2,),
                          new SizedBox(width: 10),
                          new Image.asset("design/good.png",scale: 2,),
                          new SizedBox(width: 10),
                          new Image.asset("design/smile.png",scale: 2,),
                        ])),
                new SizedBox(height: 15),
                new InkWell(
                    onTap: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => new PublicarPost(titulo: titulo,comentario: comentario,)));
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
                                    color: Colors.white)))))
              ]),
        ),
      ),
    );
  }
}