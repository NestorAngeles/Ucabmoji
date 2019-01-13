import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter_ucabmoji/ajustes.dart';
import 'package:flutter_ucabmoji/services/usermanagement.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart' as random;

class ProfilePage extends StatefulWidget {

  ProfilePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _ProfilePageState createState() => new _ProfilePageState(onSignedOut: onSignedOut);
}

class _ProfilePageState extends State<ProfilePage> {

  _ProfilePageState({this.onSignedOut});

  final VoidCallback onSignedOut;

  var profilePicUrl = 'https://firebasestorage.googleapis.com/v0/b/proyecto-ucabmoji.appspot.com/o/icon2.png?alt=media&token=1e8892f2-9da7-46f6-836a-936a51d234ca';

  var nickName = '';
  bool isLoading = false;
  File selectedImage;
  UserManagement userManagement = new UserManagement();
  String newNickName;

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        profilePicUrl = user.photoUrl;
        nickName = user.displayName;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future selectPhoto() async {
    setState(() {
      isLoading = true;
    });
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 300,maxHeight: 300);

    setState(() {
      selectedImage = tempImage;
      uploadImage();
    });
  }

  Future uploadImage() async {
    String foto = random.randomAlphaNumeric(5)+nickName+".png";

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepics/${foto}');
    StorageUploadTask task = await firebaseStorageRef.putFile(selectedImage);

    task.future.then((value) {
      setState(() {
        userManagement
            .updateProfilePic(value.downloadUrl.toString())
            .then((val) {
          setState(() {
            profilePicUrl = value.downloadUrl.toString();
            isLoading = false;
          });
        });
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<bool> editName(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cambiar Nick Name', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 100.0,
              width: 100.0,
              child: Column(
                children: <Widget>[
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cambiar'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  userManagement.updateNickName(newNickName).then((onValue) {
                    setState(() {
                      isLoading = false;
                      nickName = newNickName;
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  getLoader() {
    return isLoading
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Perfil"),backgroundColor: Theme.of(context).primaryColor,
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
      backgroundColor: Colors.white,
        body: new Stack(
      children: <Widget>[
        Positioned(
            width: 350.0,
            left: 4.0,
            top: MediaQuery.of(context).size.height / 9,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                            image: NetworkImage(profilePicUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 20.0),
                getLoader(),
                SizedBox(height: 40.0),
                Text(
                  nickName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Estudiante',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    //Container(
                        //height: 30.0,
                        //width: 110.0,
                        //child: Material(
                          //borderRadius: BorderRadius.circular(20.0),
                          //shadowColor: Colors.greenAccent,
                          //color: Colors.green,
                          //elevation: 7.0,
                          //child: GestureDetector(
                            //onTap: () {
                              //editName(context);
                            //},
                            //child: Center(
                              //child: Text(
                                //'Editar Nombre',
                                //style: TextStyle(
                                    //color: Colors.white,
                                    //fontFamily: 'Montserrat'),
                              //),
                            //),
                          //),
                        //)),

                    Container(
                        height: 30.0,
                        width: 110.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: selectPhoto,
                            child: Center(
                              child: Text(
                                'Cambiar Foto',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        height: 30.0,
                        width: 110.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((val) {
                                //Navigator.of(context)
                                //    .pushReplacementNamed('/landingpage');
                              }).catchError((e) {
                                print(e);
                              });
                              onSignedOut();
                            },
                            child: Center(
                              child: Text(
                                'Cerrar Sesion',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ))
      ],
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
