import 'dart:async';

import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

import 'carro.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (content, index) {
          final Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  _onClickCarro(context, c);
                },
                onLongPress: () {
                  _onLongClickCarro(context, c);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                        onPressed: () => _pushCarroPage(context, c),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        child: const Text('Share'),
                        onPressed: () => _onClickShare(context, c),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _pushCarroPage(context, Carro c) {
    push(context, CarroPage(c));
  }

  _onClickCarro(context, Carro c) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(c.nome, style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold
                ),),
              ),
              ListTile(
                title: Text("Detalhes"),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  Navigator.pop(context);
                  _pushCarroPage(context, c);
                },
              ),
              ListTile(
                  title: Text("Share"),
                  leading: Icon(Icons.share),
                  onTap: () {
                    _onClickShare(context, c);
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  _onLongClickCarro(BuildContext context, Carro c) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(c.nome),
            children: <Widget>[
              ListTile(
                title: Text("Detalhes"),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  Navigator.pop(context);
                  _pushCarroPage(context, c);
                },
              ),
              ListTile(
                  title: Text("Share"),
                  leading: Icon(Icons.share),
                  onTap: () {
                    _onClickShare(context, c);
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  _onClickShare(BuildContext context, Carro c) {
    Share.share(c.urlFoto);
  }
}
