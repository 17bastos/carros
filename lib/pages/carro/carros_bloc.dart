import 'dart:async';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc {


  final _streamController = StreamController<List<Carro>>();
  get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
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