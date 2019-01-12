import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/ajustes.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mensajes"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Ajustes()));
                }
            ),]),
      body:
      Container(
      child: Center(
        child: Text('No hay mensajes'),
      )
    ));
  }
}