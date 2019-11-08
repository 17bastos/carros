import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/drawer-list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Clássicos",),
              Tab(text: "Esportivos",),
              Tab(text: "Luxo",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CarrosListView("classicos"),
            CarrosListView("esportivos"),
            CarrosListView("luxo")
          ],
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
