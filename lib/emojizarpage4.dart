import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/homepage.dart';
import 'package:flutter_ucabmoji/widgets/post.dart';

class PublicarPost extends StatelessWidget {

  PublicarPost({this.titulo,this.comentario,this.image});

  String titulo, comentario, nickName,profilePicUrl;

  File image;

  _sendToServer() async {
    await FirebaseAuth.instance.currentUser().then((user) {
        profilePicUrl = user.photoUrl;
        nickName = user.displayName;
    }).catchError((e) {
      print(e);
    });
      print(nickName);
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "titulo": titulo,
        "comentario": comentario,
        "ubicacion": 0,
        "emoji": 0,
        "nickName": nickName,
        "profilePic": profilePicUrl
      };
      ref.child('Post').push().set(data);
      print("posted");
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Publicar"),
        ),
        body: Column(children: <Widget>[
            SizedBox(height: 100),
            Post(titulo: titulo,comentario: comentario),
            SizedBox(height: 100),
            InkWell(
            onTap: () {
              _sendToServer();
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child:
            Container(
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
                        color: Colors.white))))),
        ])
    );
  }
}
