import 'dart:async';
import 'package:carros/utils/network.dart';

import 'carro.dart';
import 'carro_dao.dart';
import 'carros_api.dart';

class CarrosBloc {


  final _streamController = StreamController<List<Carro>>();
  get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {

      bool networkOn = await isNetworkon();

      List<Carro> carros;
      if (!networkOn) {
        carros = await CarroDAO().findAllByTipo(tipo);
      } else {
        carros = await CarrosApi.getCarros(tipo);
      }

      final dao = CarroDAO();
      carros.forEach(dao.save);

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