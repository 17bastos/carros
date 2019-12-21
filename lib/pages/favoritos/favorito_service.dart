import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';

import 'favorito.dart';
import 'favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();
    final exists = await dao.exists(c.id);

    if (exists) {
      dao.delete(c.id);
      return false;
    } else {
      dao.save(f);
      return true;
    }

  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query("select c.* from carro c, favorito f where f.id = c.id");
    return carros;
  }

  static Future<bool> isFavorio(Carro c) async {
    final dao = FavoritoDAO();
    final exists = await dao.exists(c.id);

    return exists;
  }
}