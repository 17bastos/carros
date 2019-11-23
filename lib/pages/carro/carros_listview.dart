import 'dart:async';

import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'carro.dart';
import 'carros_api.dart';

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
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: c.urlFoto,
                      placeholder: (context, url) => CircularProgressIndicator(),
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
                      onPressed: () => _onClickCarro(context, c),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: const Text('Share'),
                      onPressed: () => _onClickCarro(context, c),
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

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

}
