import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/signuppage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState(onSignedIn: onSignedIn);
}

class _LoginPageState extends State<LoginPage> {

  _LoginPageState({this.onSignedIn});
  final VoidCallback onSignedIn;

  String _email;
  String _password;

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
                          labelText: 'Correo UCAB',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                      onChanged: (val) {
                        _password = val;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).primaryColor,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password)
                                .then((FirebaseUser user) {
                              widget.onSignedIn();
                              //Navigator.of(context).pushReplacementNamed('/homepage');
                            }).catchError((e) {
                              print(e);
                            });
                          },
                          child: Center(
                            child: Text(
                              'Iniciar Sesion',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    //Container(
                    //  height: 40.0,
                    //  color: Colors.transparent,
                    //  child: Container(
                    //    decoration: BoxDecoration(
                    //        border: Border.all(
                    //            color: Colors.black,
                    //            style: BorderStyle.solid,
                    //            width: 1.0),
                    //        color: Colors.transparent,
                    //        borderRadius: BorderRadius.circular(20.0)),
                    //    child: Row(
                    //      mainAxisAlignment: MainAxisAlignment.center,
                    //      children: <Widget>[
                            // Center(
                            //   child:
                            //       ImageIcon(AssetImage('assets/facebook.png')),
                            // ),
                            // SizedBox(width: 10.0),
                            //Center(
                            //  child: Text('Log in with facebook',
                            //      style: TextStyle(
                            //          fontWeight: FontWeight.bold,
                            //          fontFamily: 'Montserrat')),
                            //)
                          //],
                        //),
                      //),
                    //)
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '¿No tienes cuenta?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new SignupPage(onSignedIn: onSignedIn,) ));
                    //Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
