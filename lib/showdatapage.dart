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
        margin: EdgeInsets.all(15.0),
        elevation:4,
        child:
        //Container(color: Theme.of(context).primaryColor,padding: EdgeInsets.all(20),child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(color: Theme.of(context).accentColor,
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
              //new Image.file(
                //image,height: 120,width: 120,
                //fit: BoxFit.cover,
              //),
              //),
              Divider(),
              Container(//color:Theme.of(context).accentColor,
                child:Column(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Long:  / Lat: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
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

              ),]));
  }

}
