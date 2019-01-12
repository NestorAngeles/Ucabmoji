import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_ucabmoji/selectprofpic.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//services
import 'services/usermanagement.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  _SignupPageState createState() => _SignupPageState(onSignedIn: onSignedIn);
}

class _SignupPageState extends State<SignupPage> {

  _SignupPageState({this.onSignedIn});
  final VoidCallback onSignedIn;

  String _email;
  String _password;
  String _nickName;

  List<String> nicks = new List();

  void initState() {

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Nicks').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      nicks.clear();
      for (var key in keys) {
        print(data[key]['nickName']);
        String d = data[key]['nickName'];
        nicks.add(d);
      }
      setState(() {
        print('Length : ${nicks.length}');
      });
    });

  }

  bool comprobarNick(){
    bool seguir;

    if(nicks.contains(_nickName.toLowerCase())){
      showToast(" Ya esta existe ese NickName", false);
      seguir = false;
      return seguir;
    }else{
      seguir = true;
      return seguir;
    }

  }

  subirNick(){
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "nickName": _nickName.toLowerCase(),
    };
    ref.child('Nicks').push().set(data);
    print("posted nick");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                  child: new Center(
                    child: new Image.asset("design/ucabista.png",scale: 3,),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'NICK NAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                        onChanged: (val) {
                          _nickName = val;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'CORREO UCAB ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                        onChanged: (val) {
                          _email= val;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'CONTRASEÑA ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                        onChanged: (val) {
                          _password = val;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).primaryColor,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {

                                if(comprobarNick() && emailUcab() && validarClave()){
                                  showToast("Registrando Usuario", true);
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _email, password: _password)
                                    .then((signedInUser) {
                                  var userUpdateInfo = new UserUpdateInfo();
                                  userUpdateInfo.displayName = _nickName;
                                  userUpdateInfo.photoUrl =
                                      'https://firebasestorage.googleapis.com/v0/b/proyecto-ucabmoji.appspot.com/o/icon2.png?alt=media&token=1e8892f2-9da7-46f6-836a-936a51d234ca';
                                  FirebaseAuth.instance
                                      .updateProfile(userUpdateInfo)
                                      .then((user) {
                                    FirebaseAuth.instance
                                        .currentUser()
                                        .then((user) {
                                      UserManagement()
                                          .storeNewUser(user, context);
                                      widget.onSignedIn();
                                      subirNick();
                                      Navigator.pop(context);
                                      //Navigator.push(context,
                                      //    new MaterialPageRoute(builder: (context) => new SelectprofilepicPage(onSignedIn: onSignedIn)));
                                    }).catchError((e) {
                                      print(e);
                                      showToast(e.toString(),false);
                                    });
                                  }).catchError((e) {
                                    print(e);
                                    showToast(e.toString(),false);
                                  });
                                }).catchError((e) {
                                  print(e);
                                  showToast(e.toString(),false);

                                });
                              }},
                              child: Center(
                                child: Text(
                                  'Registrarse',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('Volver',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }


  bool emailUcab(){
    if(_email.endsWith("@est.ucab.edu.ve") || _email.endsWith("@ucab.edu.ve"))
      return true;
    else {
      showToast("Correo Invalido", false);
      return false;
    }
  }

  bool validarClave(){
    if(_password.length<6){
      showToast("La contraseña deben ser mínimo 6 caracteres", false);
      return false;
    }else{
      return true;
    }
  }

  void showToast (String alerta, bool color) {
    String error;

    if(alerta.contains("The email address is already in use by another account."))
      alerta = "Existe una cuenta registrada con este correo";

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
