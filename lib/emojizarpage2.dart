import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/emojizarpage3.dart';
import 'package:image_picker/image_picker.dart';


class Camara extends StatefulWidget {
  @override
  _CamaraState createState() => new _CamaraState();
}

class _CamaraState extends State<Camara> {

  int dkPurple = 0xFF2C1656;
  int lgPurple = 0xFF423261;

  int indexActual = 1;

  File _image;

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
      var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 720,maxWidth: 720);
      setState(() {
        _image = image;
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
      ),

      //CUERPO DONDE SE UBICA LA IMAGEN CAPTURADA---------------------------
      body: new Center(
        child: _image == null
            ? new Text('No image selected')
            : new Image.file(_image),
      ),

      //BARRA INFERIOR QUE CONTIENE LOS 3 BOTONES FUNCIONALES-------------------
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: new IconButton (icon: Image.asset("design/no_icon.png"), onPressed: deleteImage),
              title: new Text("")),
          BottomNavigationBarItem(
              icon: new IconButton (icon: Image.asset("design/camera_icon.png",height: 100,width: 100), onPressed: (){getImage();}),
              title: new Text("")),
          BottomNavigationBarItem(
              icon: new IconButton (icon: Image.asset("design/yes_icon.png"), onPressed: (){
                Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new CrearPublicacion(image: _image,)));
                }),
              title: new Text("")),
        ],

        currentIndex: indexActual,
        onTap: _onItemTapped,
        fixedColor: Color(lgPurple),

      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      indexActual = index;
    });
  }


}