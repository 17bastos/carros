import 'dart:async';


import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favoritos_bloc.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro> carros;

  @override
  void initState() {
    super.initState();
    Provider.of<FavoritosBloc>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: Provider.of<FavoritosBloc>(context, listen: false).stream,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os favoritos");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(onRefresh: _onRefresh, child: CarrosListView(snapshot.data),);
      },
    );
  }


  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() {
    return Provider.of<FavoritosBloc>(context, listen: false).fetch();
  }
}
