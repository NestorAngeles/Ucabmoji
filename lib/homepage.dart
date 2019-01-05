import 'package:flutter_ucabmoji/auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ucabmoji/emojizarpage.dart';

import 'profilepage.dart';
import 'dashboard.dart';
import 'chatpage.dart';
import 'groups.dart';

class HomePage extends StatefulWidget {

  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState(onSignedOut: onSignedOut);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  _HomePageState({this.onSignedOut});
  final VoidCallback onSignedOut;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.home)),
            new Tab(icon: Icon(Icons.chat)),
            new Tab(icon: Icon(Icons.camera)),
            new Tab(icon: Icon(Icons.my_location)),
            new Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          new DashboardPage(),
          new ChatPage(),
          new Emojizar(),
          new GroupsPage(),
          new ProfilePage(onSignedOut: onSignedOut)
        ],
      ),
        );
  }
}
