import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Acerca De"),backgroundColor: Theme.of(context).primaryColor,),
      body: Image.asset("design/acerca_de.png"),
    );
  }
}
