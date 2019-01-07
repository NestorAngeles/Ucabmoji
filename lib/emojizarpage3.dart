import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage4.dart';
import 'package:flutter_ucabmoji/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CrearPublicacion extends StatefulWidget {

  CrearPublicacion({this.onSignedOut,this.image,this.lat,this.long});
  final VoidCallback onSignedOut;
  double lat,long;

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

  String titulo, emoji, comentario, image;

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
      appBar: new AppBar(
        title: new Text(''),
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
      floatingActionButton: new FloatingActionButton(
          onPressed: (){
            print(widget.long);
            print(widget.lat);
            if(nextPage()){
              sendNick();
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
              )));
            }
          },
          tooltip: "Add Image",
          child: Icon(Icons.check)),
    );
  }

  Widget FormUI() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child:
        new Image.file(widget.image,scale: 3),),
        new SizedBox(height: 20,),
        new Divider(indent: 1,height: 10,),
        new Row(
          children: <Widget>[
            new Flexible(
              child: new TextFormField(
                decoration: new InputDecoration(hintText: 'Titulo',hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
                validator: validateName,
                onSaved: (val) {
                  titulo = val;
                },
                maxLength: 32,
              ),
            ),
            new SizedBox(width: 20.0),
            new DropdownButtonHideUnderline(
                child: new DropdownButton(
                  items: items,
                  hint: new Text("Emoji"),
                  value: emoji,
                  onChanged: (String val) {
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
          maxLines: 5,
          maxLength: 200,
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