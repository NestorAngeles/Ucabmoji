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

  PublicarPost({this.onSignedOut,this.titulo,this.comentario,this.image,this.emoji,this.lat,this.long,this.nickName,this.profilePicUrl});

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
          Card(
              margin: EdgeInsets.all(15.0),
              elevation:4,
              child:
          //Container(color: Theme.of(context).primaryColor,padding: EdgeInsets.all(20),child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Container(color: Theme.of(context).primaryColor,
            child:
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0,0, 5.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    //Row(
                      //children: <Widget>[

                        //new Container(
                          //height: 40.0,
                          //width: 40.0,
                          //decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            //image: new DecorationImage(
                                //fit: BoxFit.fill,
                                //image: new NetworkImage(
                                    //"https://firebasestorage.googleapis.com/v0/b/proyecto-ucabmoji.appspot.com/o/icon2.png?alt=media&token=1e8892f2-9da7-46f6-836a-936a51d234ca")),
                          //),
                        //),


                        new SizedBox(
                          width: 10.0,
                        ),
                        new Text(
                          titulo,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                        ),
                      //],
                    //),
                    new IconButton(
                      icon: Icon(Icons.more_vert,color: Colors.white),
                      onPressed: null,
                    )
                  ],
                ),
              ),),


              Divider(),
              //Center(
                //fit: FlexFit.loose,
                //child:
                new Image.file(
                image,height: 120,width: 120,
                  //fit: BoxFit.cover,
                ),
              //),
              Divider(),
              Container(//color:Theme.of(context).accentColor,
                child:Column(
              children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Long: $long / Lat: $lat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  comentario,
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      height: 40.0,
                      width: 40.0,
                      child: Image.asset("design/$emoji.png"),),
                    new SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: new Text(nickName,style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,15,0),
                  child:
                  Text(DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
                      style: TextStyle(color: Colors.grey))),
                  ],
                ),
              ),
            ],
          ),
          //),

          ),])),


            SizedBox(height: 25,),
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
