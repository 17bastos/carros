import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FavoritoService().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os favoritos");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros =
            snapshot.data.documents.map((DocumentSnapshot document) {
          return Carro.fromMap(document.data);
        }).toList();

        return CarrosListView(carros);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
