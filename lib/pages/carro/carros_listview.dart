import 'package:flutter/material.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosListView extends StatefulWidget {

  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView>{
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carro>> future = CarrosApi.getCarros(widget.tipo);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }

        List<Carro> carros = snapshot.data;
        return _ListViewCarros(carros);
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
                      loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ?
                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
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
                      ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              color: Colors.blue,
                              child: const Text('Detalhes'),
                              onPressed: () {},
                            ),FlatButton(
                              color: Colors.blue,
                              child: const Text('Share'),
                              onPressed: () {},
                            ),
                          ]
                      )
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
}
