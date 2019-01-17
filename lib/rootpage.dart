import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter_ucabmoji/homepage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';


class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<RootPage> createState() => new _RootPageState();
}

//DIFERENTES ESTADOS EN LOS QUE PUEDE ESTAR EL USUARIO--------------------------
enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;
  String _userId = "";

  //FUNCION PARA SABER SI AL INICIAR LA APP YA HABIA UNA SESION INICIADA--------
  @override
  initState() {
    super.initState();

    widget.auth.currentUser().then((userId){
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  //CAMBIOS DE ESTADO---------------------------------------------------------
  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  //PAGINA DE CONTROL PARA CUANDO NO SE A INICIADO LA SESION MOSTRAR EL LOGIN
  @override
  Widget build(BuildContext context) {
    
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
            onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return new HomePage(
          onSignedOut: _signedOut,
        );
    }
  }
}