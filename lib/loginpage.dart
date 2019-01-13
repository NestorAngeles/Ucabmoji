import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/signuppage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final formKey = new GlobalKey<FormState>();


  bool emailUcab(String correo){
    String email = correo;

    if(email.endsWith("@est.ucab.edu.ve") || email.endsWith("@ucab.edu.ve"))
      return true;
    else
      return false;
  }

  String validadorCorreo(String value){
    if(value.isEmpty)
      return "Correo vacio";
    if(!emailUcab(value))
      return "Correo Invalido (ejemplo@est.ucab.edu.ve)";
  }

  String validadorPassword(String value){
    if(value.isEmpty)
      return "Contraseña vacia";
    if(value.length<6)
      return "Minimo 6 caracteres";
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (emailUcab(_email)) {
        print("Email: $_email, Contraseña: $_password");
        return true;
      } else {
        print("Form is invalid");
        return false;
      }
    }else{
      print("Form is invalid");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body:new SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
        Form(
        key: formKey,
            child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80.0),
            Container(
              child: new Center(
                child: new Image.asset("design/ucabista.png",scale: 3),
              )),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Correo UCAB',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                      onSaved: (value) {
                        _email = value;
                      },
                      validator: (value) => validadorCorreo(value) ,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
                      onSaved: (val) {
                        _password = val;
                      },
                      validator: (value) => validadorPassword(value) ,
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    //Container(
                      //alignment: Alignment(1.0, 0.0),
                      //padding: EdgeInsets.only(top: 15.0, left: 20.0),
                     // child: InkWell(
                        //child: Text(
                          //'Forgot Password',
                          //style: TextStyle(
                              //color: Theme.of(context).accentColor,
                              //fontWeight: FontWeight.bold,
                            //  fontFamily: 'Montserrat',
                          //    decoration: TextDecoration.underline),
                        //),
                      //),
                    //),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).primaryColor,
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {
                            if(validateAndSave()) {
                              showToast("Iniciando Sesion", true);
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                                  .then((FirebaseUser user) {
                                widget.onSignedIn();
                                //Navigator.of(context).pushReplacementNamed('/homepage');
                              }).catchError((e) {
                                showToast(e.toString(), false);
                                print(e);
                              });
                            }
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
        ),),
            SizedBox(height: 200,)

          ])));
  }

  void showToast (String alerta, bool color) {
    String error;

    if(alerta.contains("There is no user record corresponding to this identifier."))
      alerta = "No existe alguna cuenta con esta direccion de correo";

    if(alerta.contains("The password is invalid or the user does not have a password."))
      alerta = "La contraseña es invalida";

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
