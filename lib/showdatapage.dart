import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  String nick,fotoUrl;

    getnickName() async{
    await FirebaseAuth.instance.currentUser().then((user) {
      nick = user.displayName;
    }).catchError((e) {
      print(e);
    });}


    getUrl(String fotoId) async {
    print("Comenzo");

    final ref =  FirebaseStorage.instance.ref().child("PostFotos").child(fotoId);//.child(fotoId); //child("D1260Nes.png");
    String url =  await ref.getDownloadURL(); //as String;
    print(url);

    //fotoUrl = "https://firebasestorage.googleapis.com/v0/b/proyecto-ucabmoji.appspot.com/o/icon2.png?alt=media&token=1e8892f2-9da7-46f6-836a-936a51d234ca";

    if(url != null)
      fotoUrl = url;

    print("fotoUrl $fotoUrl");

    //print(url);

    print("Termino");
  }

  crearMyData() async{

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Post').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        print(data[key]['lugar']);
        print(data[key]['latitud']);
        //getUrl(data[key]['fotoId']);

        //getUrl(data[key]['fotoId']);

        myData d = new myData(
          data[key]['titulo'],
          data[key]['comentario'],
          data[key]['nickName'],
          data[key]['emoji'],
          data[key]['fotoUrl'],
          data[key]['dia'],
          data[key]['mes'],
          data[key]['año'],
          data[key]['lugar']
          //data[key]['latitud'],
          //data[key]['longitud'],
        );
        //print(d.fotoId);

        allData.add(d);
      }


      for (var key in keys) {
        if(nick==data[key]['nickName']) {
          myData e = new myData(
            data[key]['titulo'],
            data[key]['comentario'],
            data[key]['nickName'],
            data[key]['emoji'],
            data[key]['fotoUrl'],
            data[key]['dia'],
            data[key]['mes'],
            data[key]['año'],
              data[key]['lugar']
            //data[key]['latitud'],
            //data[key]['longitud'],
          );
          allData2.add(e);
          //print(e.fotoId);
        }
      }


      setState(() {
        print('Length : ${allData.length}');
        print('Length : ${allData2.length}');
      });
    });

  }

  @override
  void initState() {
      //super.initState();
    getnickName();
    print("aqui");
    //getUrl();
    crearMyData();
    controller = new TabController(length: 2, vsync: this);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
                    //getUrl(allData[index].fotoId);
                    return UI(
                      allData[index].titulo,
                      allData[index].comentario,
                      allData[index].nickName,
                      allData[index].emoji,
                      allData[index].fotoUrl,
                      allData[index].dia,
                      allData[index].mes,
                      allData[index].year,
                      allData[index].lugar,
                      //allData[index].lat,
                      //allData[index].long
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
                    //getUrl(allData2[index].fotoId);
                    return UI(
                      allData2[index].titulo,
                      allData2[index].comentario,
                      allData2[index].nickName,
                      allData2[index].emoji,
                      allData2[index].fotoUrl,
                        allData2[index].dia,
                        allData2[index].mes,
                        allData2[index].year,
                        allData2[index].lugar,
                        //allData2[index].lat,
                        //allData2[index].long
                    );
                  },
                )),
          ]),
    );
  }


  Widget UI(String titulo, String comentario, String nickName,String emoji,var fotoUrl,
      int dia, int mes, int year,
      //double lat, double long,
      String lugar,
      ){
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
              //  child:fotoUrl == null
              //      ? new Text('No image selected')
              //      : new Image.network(fotoUrl)
              //),
              //Text(fotoUrl),
              Image.network(fotoUrl, width: 200,height: 200,),
              //Text(fotoId),
              //Center(
              //fit: FlexFit.loose,
              //child:
                  //new Image.asset("design/ucabista.png", scale: 5,)
              //new Image.network(getUrl(fotoId)
                //fotoId ,height: 120,width: 120,
                //fit: BoxFit.cover,
              //),
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
                      child: Text("$lugar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    ),
                    ]),
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
                              Text(dia.toString()+"/"+mes.toString()+"/"+year.toString(),
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
