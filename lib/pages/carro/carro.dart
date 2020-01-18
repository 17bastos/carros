import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/sql/entity.dart';
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarroEvent extends Event {
  String acao;
  String tipo;

  CarroEvent(this.acao, this.tipo);

  @override
  String toString() {
    return 'CarroEvent{acao: $acao, tipo: $tipo}';
  }

}

class Carro extends Entity{
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro(
      {this.id,
        this.nome,
        this.tipo,
        this.descricao,
        this.urlFoto,
        this.urlVideo,
        this.latitude,
        this.longitude});

  Carro.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    descricao = json['descricao'];
    urlFoto = json['urlFoto'] != null ? json['urlFoto'] : "";
    urlVideo = json['urlVideo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['descricao'] = this.descricao;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    return convert.json.encode(this.toMap());
  }

  latLng() {
    return LatLng(
      latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
      longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude)
    );
  }
}
