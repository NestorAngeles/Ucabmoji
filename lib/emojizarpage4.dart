import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/homepage.dart';
import 'package:flutter_ucabmoji/rootpage.dart';
import 'package:flutter_ucabmoji/widgets/post.dart';
import 'package:random_string/random_string.dart' as random;

class PublicarPost extends StatelessWidget {

  PublicarPost({this.onSignedOut,this.titulo,this.comentario,this.image,this.emoji,this.lat,this.long});

  final VoidCallback onSignedOut;
  String titulo, comentario, nickName,profilePicUrl,foto,emoji;
  double lat,long;
  File image;

  _sendToServer() async {

    await FirebaseAuth.instance.currentUser().then((user) {
        profilePicUrl = user.photoUrl;
        nickName = user.displayName;
    }).catchError((e) {
      print(e);
    });

      print(nickName);
      foto = random.randomAlphaNumeric(5)+nickName+".png";
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('PostFotos/${foto}');
    final StorageUploadTask task = firebaseStorageRef.putFile(image);


    Firestore.instance.collection('/Post').add({
      "titulo": titulo,
      "comentario": comentario,
      "ubicacion": 0,
      "emoji": emoji,
      "nickName": nickName,
      "profilePic": profilePicUrl,
      "fotoId": foto,
      "latitud":lat,
      "longitud": long,
      //"momento" : DateTime.now(),
      "dia" : DateTime.now().day,
      "mes" : DateTime.now().month,
      "año" : DateTime.now().year,
      "hora" : DateTime.now().hour,
      "minutos" : DateTime.now().minute
    });

      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "titulo": titulo,
        "comentario": comentario,
        "ubicacion": 0,
        "emoji": emoji,
        "nickName": nickName,
        "profilePic": profilePicUrl,
        "fotoId": foto,
        //"momento" : DateTime.now(),
        "dia" : DateTime.now().day,
        "mes" : DateTime.now().month,
        "año" : DateTime.now().year,
        "hora" : DateTime.now().hour,
        "minutos" : DateTime.now().minute
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
            Post(titulo: titulo,comentario: comentario,image: image),
            SizedBox(height: 100),
            InkWell(
            onTap: () {
              _sendToServer();
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new RootPage(auth: new Auth())));
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
