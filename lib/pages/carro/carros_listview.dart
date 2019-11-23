import 'dart:async';

import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _ListViewCarros(snapshot.data);
      },
    );
  }

  Container _ListViewCarros(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (content, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto,
                      width: 250,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    c.nome,
                    style: TextStyle(fontSize: 25),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    c.descricao,
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ButtonBar(children: <Widget>[
                    FlatButton(
                      color: Colors.blue,
                      child: const Text('Detalhes'),
                      onPressed: () => _onClickCarro(c),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: const Text('Share'),
                      onPressed: () => _onClickCarro(c),
                    ),
                  ])
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
