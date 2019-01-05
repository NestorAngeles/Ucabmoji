import 'package:flutter/material.dart';
import 'package:flutter_ucabmoji/widgets/post.dart';

class PublicarPost extends StatelessWidget {

  String titulo = "Hola",
      comentario = "Gay";

  @override
  Widget build(BuildContext context) {
    return new Post(titulo: titulo, comentario: comentario);
  }
}