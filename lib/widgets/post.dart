import 'package:flutter/material.dart';

class Post extends StatelessWidget {

  Post({this.titulo, this.comentario});

  String titulo, comentario;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: Text(titulo,
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),),
                    Container(
                      padding: EdgeInsets.fromLTRB(260.0, 55.0, 0.0, 0.0),
                      child: Text(
                        comentario,
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    )
                  ],
                ),
              ),
            ]));
  }

}