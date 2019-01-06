import 'dart:io';

import 'package:flutter/material.dart';

class Post extends StatelessWidget {

  Post({this.titulo, this.comentario,this.image});

  String titulo, comentario;

  File image;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Theme.of(context).primaryColor,
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              color: Colors.white,
              child:
            new Center(
              child: new Text(titulo,style: TextStyle(color: Colors.black),),),),
            new Center(
              child: Image.file(image,scale: 5,),),
              //child: new Image.network("https://firebasestorage.googleapis.com/v0/b/proyecto-ucabmoji.appspot.com/o/icon2.png?alt=media&token=726d4d91-7c5b-41a4-a728-9456f418549e", scale: 5)),
            new Center(
              child: new Text(comentario,style: TextStyle(color: Colors.white)),)

          ],
        ),
      );

  }

}