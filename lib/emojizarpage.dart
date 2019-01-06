import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage2.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Emojizar extends StatefulWidget {
  @override
  _EmojizarState createState() => _EmojizarState();
}

class _EmojizarState extends State<Emojizar> {
  @override

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;
  int bgPurple = 0xFFC7B8E4;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body:  Container(
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Image.asset('design/ucabista.png', width: 230.0, height: 286.0,),
                      new InkWell(
                          onTap: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => new Camara()));
                          },
                          child: new Container(
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
                                          color: Colors.white)))))]))));
  }

}