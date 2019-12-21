import 'package:carros/pages/carro/carro.dart';
import 'package:carros/utils/sql/entity.dart';

class Favorito extends Entity {
  int id;
  String nome;

  Favorito();

  Favorito.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Favorito.fromCarro(Carro c) {
    id = c.id;
    nome = c.nome;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}