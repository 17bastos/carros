import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/pages/favoritos/favoritos_page.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/drawer-list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = await Prefs.getInt("tabIdx");

    _tabController.addListener((){
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: "Clássicos", icon: Icon(Icons.directions_car),),
              Tab(text: "Esportivos", icon: Icon(Icons.directions_car),),
              Tab(text: "Luxo", icon: Icon(Icons.directions_car),),
              Tab(text: "Favoritos", icon: Icon(Icons.favorite),),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            CarrosPage("classicos"),
            CarrosPage("esportivos"),
            CarrosPage("luxo"),
            FavoritosPage()
          ],
        ),
        drawer: DrawerList(),
      );
  }
}
