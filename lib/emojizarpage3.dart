import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage4.dart';
import 'package:flutter_ucabmoji/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart' as random;

class CrearPublicacion extends StatefulWidget {

  CrearPublicacion({this.onSignedOut,this.image,this.lat,this.long,this.lugar});
  final VoidCallback onSignedOut;
  double lat,long;
  String lugar;
  File image;

  @override
  _CrearPublicacionState createState() => new _CrearPublicacionState();
}


class _CrearPublicacionState extends State<CrearPublicacion> {

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  String nickName, profilePicUrl;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;

  String titulo, emoji, comentario, image,foto;

  Color siguiente;
  String boton="";


  publicarFoto(){
    foto = random.randomAlphaNumeric(5)+nickName+".png";

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('PostFotos/${foto}');
    final StorageUploadTask task = firebaseStorageRef.putFile(widget.image);
  }


  bool nextPage(){
  if (_key.currentState.validate()) {
  _key.currentState.save();
  if(isEmoji())
  return true;
  else
  return false;
  }else{
  return false;
  }
  }

  bool isEmoji(){
  if(emoji!=null) {
  return true;
  }else {
  showToast("Debes seleccionar un Emoji", false);
  return false;
  }
  }

  sendNick() async{
  await FirebaseAuth.instance.currentUser().then((user) {
  profilePicUrl = user.photoUrl;
  nickName = user.displayName;
  }).catchError((e) {
  print(e);
  });

  }


  List<DropdownMenuItem<String>> items = [
  new DropdownMenuItem(
  child: new Image.asset("design/smile.png"),
  value: 'smile',
  ),
  new DropdownMenuItem(
  child: new Image.asset("design/good.png"),
  value: 'good',
  ),
  new DropdownMenuItem(
  child: new Image.asset("design/sad.png"),
  value: 'sad',
  ),
  new DropdownMenuItem(
  child: new Image.asset("design/angry.png"),
  value: 'angry',
  ),
  ];

  @override
  Widget build(BuildContext context) {
  return new Scaffold(
  //resizeToAvoidBottomPadding: false,
  appBar: new AppBar(
  title: new Text('Emojizar'),
  actions: <Widget>[
  FlatButton(
  child: Text(boton,style: TextStyle(color: Colors.green,fontSize: 20)),
  onPressed: (){
  print(widget.long);
  print(widget.lat);
  if(nextPage()){
    print("there");
  sendNick();
  publicarFoto();
  Navigator.push(context,
  new MaterialPageRoute(builder: (context) => new PublicarPost(
  titulo: titulo,
  comentario:comentario,
  image:widget.image,
  emoji:emoji,
  onSignedOut: widget.onSignedOut,
  lat: widget.lat,
  long: widget.long,
  nickName: nickName,
  profilePicUrl: profilePicUrl,
  foto: foto,
  lugar: widget.lugar
  )));
  }
  },
  )
  ],
  ),
  body: new SingleChildScrollView(
  child: new Container(
  padding: new EdgeInsets.all(15.0),
  child: new Form(
  key: _key,
  autovalidate: _autovalidate,
  child: FormUI(),
  ),
  ),
  ),
  //floatingActionButton: new FloatingActionButton(
  //  onPressed: (){

  //},
  //tooltip: "Add Image",
  //child: Icon(Icons.check)),
  );
  }

  Widget FormUI() {
  return new Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Center(
  child:
  new Image.file(widget.image,scale: 1.5),),
  new Divider(indent: 1,height: 10,),
  Center(
  child:
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
  ),
  Divider(),
  new Row(
  children: <Widget>[
  new Flexible(
  child: new TextFormField(
  decoration: new InputDecoration(hintText: 'Titulo',hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
  validator: validateName,
  onSaved: (val) {
  titulo = val;
  },
  maxLength: 25,
  ),
  ),
  new SizedBox(width: 20.0),
  new DropdownButtonHideUnderline(
  child: new DropdownButton(
  items: items,
  hint: new Text("Emoji"),
  value: emoji,
  onChanged: (String val) {
  boton="Siguiente";
  setState(() {
  emoji = val;
  });
  },
  ))
  ],
  ),
  new TextFormField(
  decoration: new InputDecoration(hintText: 'Comentario',hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
  onSaved: (val) {
  comentario = val;
  },
  validator: validateMessage,
  maxLines: 4,
  maxLength: 200,
  maxLengthEnforced: true,
  ),

  ],
  );
  }

  String validateName(String val) {
  return val.length == 0 ? "Debes escribir un titulo" : null;
  }

  String validateMessage(String val) {
  return val.length == 0 ? "Debes escribir un comentario" : null;
  }

  void showToast (String alerta, bool color) {
  String error;

  Color colors;
  if(!color)
  colors = Colors.red;
  else
  colors = Colors.green;

  Fluttertoast.showToast(
  backgroundColor: colors,
  msg: alerta,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIos: 2,
  textColor: Colors.white
  );
  }

  }