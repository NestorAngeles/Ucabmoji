import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage4.dart';
import 'package:flutter_ucabmoji/homepage.dart';

class CrearPublicacion extends StatefulWidget {

  CrearPublicacion({this.onSignedOut,this.image});
  final VoidCallback onSignedOut;

  File image;

  @override
  _CrearPublicacionState createState() => new _CrearPublicacionState();
}


class _CrearPublicacionState extends State<CrearPublicacion> {

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _autovalidate = false;

  String titulo, emoji, comentario, image;

  bool nextPage(){
    if (_key.currentState.validate()) {
      _key.currentState.save();
      return true;
    }
  }


  List<DropdownMenuItem<String>> items = [
    new DropdownMenuItem(
      child: new Image.asset("design/smile.png"),
      value: 'Student',
    ),
    new DropdownMenuItem(
      child: new Image.asset("design/good.png"),
      value: 'Professor',
    ),
    new DropdownMenuItem(
      child: new Image.asset("design/sad.png"),
      value: 'Hola',
    ),
    new DropdownMenuItem(
      child: new Image.asset("design/angry.png"),
      value: 'Perro',
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
            if(nextPage()){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new PublicarPost(
                    titulo: titulo,
                    comentario:comentario,
                    image:widget.image,
                    onSignedOut: widget.onSignedOut,
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


}