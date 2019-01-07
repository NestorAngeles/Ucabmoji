import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/ajustes.dart';
import 'package:flutter_ucabmoji/myData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_ucabmoji/widgets/appbar.dart';
import 'package:flutter_ucabmoji/widgets/post.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> with SingleTickerProviderStateMixin{
  List<myData> allData = [];
  List<myData> allData2 = [];
  TabController controller;

  String nick;

  getnickName() async{
    await FirebaseAuth.instance.currentUser().then((user) {
      nick = user.displayName;
    }).catchError((e) {
      print(e);
    });}

  @override
  void initState() {
    getnickName();
    controller = new TabController(length: 2, vsync: this);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Post').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        print(data[key]['emoji']);
        myData d = new myData(
          data[key]['titulo'],
          data[key]['comentario'],
          data[key]['nickName'],
          data[key]['emoji'],
        );
        allData.add(d);
      }
      for (var key in keys) {
        if(nick==data[key]['nickName']) {
          myData e = new myData(
            data[key]['titulo'],
            data[key]['comentario'],
            data[key]['nickName'],
            data[key]['emoji'],
          );
          allData2.add(e);
        }
      }
      setState(() {
        print('Length : ${allData.length}');
        print('Length : ${allData2.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Ucabmoji Home",style: TextStyle(fontSize: 25),),
        elevation: 5,
        bottom: new TabBar(
          unselectedLabelColor: Colors.grey,
          tabs:
            <Widget>[
              new Tab(
                icon: new Icon(Icons.people),
              ),
              new Tab(
                icon: new Icon(Icons.person),
              ),
            ],
        controller: controller,
        ),

          actions: <Widget>[
      IconButton(
      icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new Ajustes()));
        }
      ),]),

      body: new TabBarView(
        controller: controller,
          children:<Widget>[
            new Container(
                child: (allData.length == 0 || allData.length == null || allData == null)
                    ? new Container(
                      child: new Center(
                        child: new Image.asset("design/sad.png"),)
                      )
                    : new ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return UI(
                      allData[index].titulo,
                      allData[index].comentario,
                      allData[index].nickName,
                      allData[index].emoji,
                    );
                  },
                )),
            new Container(
                child: (allData.length == 0 || allData.length == null || allData == null)
                    ? new Container(
                    child: new Center(
                      child: new Image.asset("design/sad.png"),)
                )
                    : new ListView.builder(
                  itemCount: allData2.length,
                  itemBuilder: (_, index) {
                    return UI(
                      allData2[index].titulo,
                      allData2[index].comentario,
                      allData2[index].nickName,
                      allData2[index].emoji,
                    );
                  },
                )),
          ]),
    );
  }


  Widget UI(String titulo, String comentario, String nickName,String emoji) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        color: Colors.white,
        padding: new EdgeInsets.all(20.0),
        child: new Row(children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text('Titulo : $titulo',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20)),
              //new Text('Profession : $profession',style: TextStyle(color: Colors.white)),
              new Text('Comentario : $comentario',style: TextStyle(color: Theme.of(context).primaryColor)),
              new Text('Usuario : $nickName',style: TextStyle(color: Theme.of(context).primaryColor)),
            ],
          ),
          new SizedBox(width: 20,),
          new Image.asset("design/${emoji}.png",scale: 2),
          new SizedBox(width: 20,),
          //new Image.asset("design/modulo_Aulas.jpg",scale: 9),
        ],)
      ),
    );
  }

}
