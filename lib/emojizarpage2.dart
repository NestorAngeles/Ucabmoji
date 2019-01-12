import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage3.dart';
import 'package:image_picker/image_picker.dart';


class Camara extends StatefulWidget {

  Camara({this.onSignedOut,this.lat,this.long,this.lugar});
  final VoidCallback onSignedOut;
  double lat,long;
  String lugar;

  @override
  _CamaraState createState() => new _CamaraState();
}

class _CamaraState extends State<Camara> {

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  String next="";

  int indexActual = 1;

  File _image;

  Color siguiente = Colors.grey;

  bool isImage=false;

  Widget callPage(int index){
    switch(index){
      default: print("hola");
    }
  }

  //---FUNCIONES DE LOS 3 BOTONES-----------------------------------------------

  void getImage() async{
    //if(_image !=null)
      //showToast("Ya hay una imagen seleccionada");
    //else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 400,maxWidth: 400);
      setState(() {
        _image = image;
        if(_image!=null) {
          siguiente = Colors.green;
          isImage = true;
          next = "Siguiente";
        }
      });
    //}

  }

  Future deleteImage() async {
    //if (_image == null)
      //showToast("No hay ninguna imagen para eliminar");
    //else {
      setState(() {
        _image = null;
      });
    //}
  }

  Future nextPage() async{
    //if(_image == null)
      //showToast("No a seleccionado ninguna imagen todavia");
    //else{
      //Pasar a la siguiente pagina.
      //showToast("next page");
    //}
  }
  //----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Emojizar'),
        backgroundColor: Color(dkPurple),
        actions: <Widget>[
          FlatButton(
            child: Text(next,style: TextStyle(color: siguiente,fontSize: 20)),
            onPressed: (){
              if(isImage) {
                print(widget.lugar);
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new CrearPublicacion(
                          image: _image,
                          onSignedOut: widget.onSignedOut,
                          lat: widget.lat,
                          long: widget.long,
                          lugar: widget.lugar)));
              }
            },
          )
        ],
      ),

      //CUERPO DONDE SE UBICA LA IMAGEN CAPTURADA---------------------------
      body: new Center(
        child: _image == null
            ? new Text('No image selected')
            : new Image.file(_image),
      ),

      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.photo_camera),
        onPressed: () {
          if(!isImage)
          getImage();
        }),

    );
  }

  void _onItemTapped(int index) {
    setState(() {
      indexActual = index;
    });
  }


}