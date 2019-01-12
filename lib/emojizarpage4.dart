import 'dart:async';
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

class PublicarPost extends StatefulWidget {

  PublicarPost({this.onSignedOut,this.titulo,this.comentario,this.image,this.emoji,this.lat,this.long,this.nickName,this.profilePicUrl,this.foto,this.lugar});

  final VoidCallback onSignedOut;
  String titulo, comentario, nickName,profilePicUrl,foto,emoji,lugar;
  double lat,long;
  File image;


  @override
  _PublicarPostState createState() => new _PublicarPostState();
}


class _PublicarPostState extends State<PublicarPost> {

  Color elcolor = Colors.grey;

  String boton= "ESPERE...";
  String url;

  bool emojizar=false;

  List<int> num = [];
  int num2;


  void initState(){
    print("initSATETE");

    Timer(Duration(seconds: 7), () {
      setState(() {
        elcolor = Colors.green;
        boton = "EMOJIZAR";
        getUrl();
        emojizar=true;
      });
    });
    numeroPost();
    //numeroPost2();
    //getUrl();
  }

  numeroPost(){

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('NumPost').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      num.clear();

      for (var key in keys) {
        //print(data[key]['num']);
        int d = data[key]['num'];
        num.add(d);
      }
      num.sort();
      setState(() {
        num2= num.last+1;
        print(num2);
        print('Length : ${num.length}');
        numeroPost2();
      });
    });
  }

  numeroPost2() {

    DatabaseReference ref2 = FirebaseDatabase.instance.reference();
    var data = {
      "num": num2,
    };
    ref2.child('NumPost').push().set(data);

  }

  getUrl() async{
    final StorageReference storageRef = FirebaseStorage.instance.ref().child('PostFotos').child(widget.foto);
    print("ke pasa");

    url = await storageRef.getDownloadURL();
    print("COÑO");
    print("Aqui esta el $url");

  }

  _sendToServer() async {


    await FirebaseAuth.instance.currentUser().then((user) {
        widget.profilePicUrl = user.photoUrl;
        widget.nickName = user.displayName;
    }).catchError((e) {
      print(e);
    });

      print(widget.nickName);

    Firestore.instance.collection('/Post').add({
      "titulo": widget.titulo,
      "comentario": widget.comentario,
      "ubicacion": 0,

      "emoji": widget.emoji,
      "nickName": widget.nickName,
      "profilePic": widget.profilePicUrl,
      "fotoId": widget.foto,

      "latitud":widget.lat,
      "longitud": widget.long,
      "lugar": widget.lugar,

      "dia" : DateTime.now().day,
      "mes" : DateTime.now().month,
      "año" : DateTime.now().year,
      "hora" : DateTime.now().hour,
      "minutos" : DateTime.now().minute,

      "fotoUrl" : 'hey',
    });

      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "titulo": widget.titulo,
        "comentario": widget.comentario,
        //"ubicacion": 0,
        "emoji": widget.emoji,

        "nickName": widget.nickName,
        "profilePic": widget.profilePicUrl,
        "fotoId": widget.foto,

        "latitud":widget.lat,
        "longitud": widget.long,
        "lugar": widget.lugar,

        "dia" : DateTime.now().day,
        "mes" : DateTime.now().month,
        "año" : DateTime.now().year,
        "hora" : DateTime.now().hour,
        "minutos" : DateTime.now().minute,

        "fotoUrl" :  url,
        "num": num2,
       };
      ref.child('Post').push().set(data).then((Value){
        print("posted");
      }).catchError((e){
        print(e);
      });

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
                          widget.titulo,
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
                widget.image,height: 200,width: 200,
                  //fit: BoxFit.cover,
                ),
              //),
              Divider(),
              Container(//color:Theme.of(context).accentColor,
                child:Column(
              children:<Widget>[
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
                        child: Text("${widget.lugar} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      ),
                    ]),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.comentario,
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
                      child: Image.asset("design/${widget.emoji}.png"),),
                    new SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: new Text(widget.nickName,style: TextStyle(fontWeight: FontWeight.bold),),
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
              if(emojizar) {
                //publicarFoto();
                //tiempo();

                _sendToServer();
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new RootPage(auth: new Auth())));
              }
            },
            child:
            Container(
            width: 200.0,
            height: 50.0,
            decoration: new BoxDecoration(
                color: elcolor,
                border: new Border.all(color: Colors.white, width: 1.5),
                borderRadius: new BorderRadius.circular(10.0)),
            child: new Center(
                child: new Text(boton,
                    style: new TextStyle(
                        fontSize: 24.0,
                        color: Colors.white))))),
        ])
    );
  }
}
