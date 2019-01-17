import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> with SingleTickerProviderStateMixin {

  TabController controller;

  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 7, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Tutorial",style:TextStyle(fontSize: 25))),
        backgroundColor: Theme.of(context).primaryColor,
        body: new TabBarView(
            children: <Widget>[
              Image.asset("design/tutorial1.png"),
              Image.asset("design/tutorial2.png"),
              Image.asset("design/tutorial3.png"),
              Image.asset("design/tutorial4.png"),
              Image.asset("design/tutorial5.png"),
              Image.asset("design/tutorial6.png"),
              Image.asset("design/tutorial7.png"),
              Image.asset("design/tutorial8.png"),

            ],
            controller: controller
        ),
      //floatingActionButton: FloatingActionButton(onPressed: (){}),
    );
  }
}
