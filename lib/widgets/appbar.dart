import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  MyAppBar({@required this.titulo});

  String titulo;

  @override
    Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
    );
  }
}
