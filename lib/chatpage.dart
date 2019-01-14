import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/ajustes.dart';
import 'package:flutter_ucabmoji/msj.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget {

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<msj> allmsj = [];
  int day,mes,year;


  void initState() {
    day=DateTime.now().day;
    mes=DateTime.now().month;
    year=DateTime.now().year;

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Mensaje').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allmsj.clear();
      for (var key in keys) {
        if(day == data[key]['dia'] && mes==data[key]['mes'] && year ==data[key]['año']){
        msj d = new msj(
          data[key]['titulo'],
          data[key]['mensaje'],
          data[key]['dia'],
            data[key]['mes'],
            data[key]['año'],
            data[key]['hora'],
        );
        allmsj.add(d);
      }}

      allmsj.sort((a,b) => a.hora.compareTo(b.hora));

      setState(() {
        print('Length : ${allmsj.length}');
      });
    });
  }

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


      body: new Container(
          child: allmsj.length == 0
              ? new Center(

                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No hay mensajes",style: TextStyle(fontSize: 25,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,),),
                        SizedBox(height: 20,),
                        Image.asset("design/good.png")
                      ],
                  ),
          )
              : new ListView.builder(
            itemCount: allmsj.length,
            itemBuilder: (_, index) {
              return UI(
                allmsj[index].titulo,
                allmsj[index].mensaje,
                allmsj[index].dia,
                allmsj[index].mes,
                allmsj[index].year,
              );
            },
          )),);
  }


  Widget UI(String titulo, String mensaje, int dia, int mes, int year) {
    return new Card(
      margin: EdgeInsets.all(5),
      elevation: 10.0,
      child:
          Container(
            padding: EdgeInsets.all(5),
      child:

      Row(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        new Image.asset("design/msj.png",scale: 5,),

        new Flexible(
        //padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                titulo,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),),
            Container(
              padding: EdgeInsets.all(2),
              child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
              child: Text(
                mensaje,
                style: TextStyle(),
                textAlign: TextAlign.justify,
              ),),)
          ],
        ),
      )],
      ))
      //crossAxisAlignment: CrossAxisAlignment.start,),
    );
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
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        textColor: Colors.white,
    );
  }
}