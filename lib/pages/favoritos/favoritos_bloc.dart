import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';

class FavoritosBloc {


  final _streamController = StreamController<List<Carro>>();
  get stream => _streamController.stream;

  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros;
      carros = await FavoritoService.getCarros();

      _streamController.add(carros);
      return carros;
    } catch (e) {
      _streamController.addError(e);
    }
  }

  dispose() {
    _streamController.close();
  }
}