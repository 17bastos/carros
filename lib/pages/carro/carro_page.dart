import 'package:carros/pages/carro/carro-form-page.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/pages/video_page.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_response.dart';
import '../mapa_page.dart';
import 'carro.dart';
import 'carros_api.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  @override
  void initState() {
    super.initState();
    FavoritoService().isFavorito(carro).then((bool favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
  }

  Color color = Colors.grey;
  Carro get carro => widget.carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {
              _onClickMapa(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              _onClickVideoVideoPlayer(context);
            },
          ),
          PopupMenuButton<String>(
              onSelected: (String value) => _onClickPopupMenu(value),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: "Editar",
                    child: Text("Editar"),
                  ),
                  PopupMenuItem(
                    value: "Deletar",
                    child: Text("Deletar"),
                  ),
                  PopupMenuItem(
                    value: "Share",
                    child: Text("Share"),
                  )
                ];
              }),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Image.network(widget.carro.urlFoto),
            _bloco1(),
            Divider(),
            _bloco2(),
          ],
        ));
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        deletar();
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20, bold: true),
            text(widget.carro.tipo)
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
            ),
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          text(widget.carro.descricao, fontSize: 16, bold: true),
          SizedBox(
            height: 20,
          ),
          text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dignissim convallis lacus, at lobortis nisl fermentum ac. Phasellus eu aliquam turpis. Phasellus viverra elementum tortor id mattis. Proin urna mauris, tincidunt sit amet blandit et, volutpat sed nibh. Aliquam sit amet nulla arcu. In tempus lacus lacus, at placerat urna sagittis quis. Sed ornare fermentum metus ut lobortis. Mauris ipsum turpis, lobortis eget ipsum quis, bibendum sodales enim.    Nullam auctor, odio quis lacinia venenatis, purus velit pretium nibh, ut bibendum sem leo vitae dui. Curabitur bibendum, dolor in eleifend egestas, odio felis sagittis nisi, at tincidunt nunc lorem id lectus. Duis tempor libero a sollicitudin venenatis. Aliquam consectetur libero in mattis volutpat. Ut at enim leo. In quis tincidunt eros, et rutrum ipsum. Cras dignissim tristique maximus. Donec eu est ligula. Mauris ultrices accumsan mauris.    Aliquam non ante nisi. Nam tristique dictum mauris ornare dapibus. Sed in lorem sed magna facilisis imperdiet. Nunc suscipit consequat mi. Aenean tincidunt imperdiet mauris, a dapibus ex rhoncus sit amet. Pellentesque porttitor urna vitae quam gravida mattis. Nam sit amet venenatis massa, sit amet posuere nibh. Aenean in augue sit amet velit facilisis ullamcorper non quis purus.    Quisque cursus, dui fringilla ornare vehicula, turpis sapien imperdiet augue, in suscipit ligula nunc et diam. Mauris luctus vulputate lacus, eu posuere ex luctus at. In nisi erat, posuere sit amet iaculis eget, sodales eget diam. Nam finibus libero ac turpis scelerisque, vel mattis metus placerat. Pellentesque justo risus, varius id metus sed, ultrices ullamcorper erat. Nulla euismod purus quis elit vestibulum, ac dignissim est blandit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ac risus fringilla, egestas urna et, iaculis est. Nunc ut efficitur nisi, ac fringilla nibh.    Sed pellentesque, nisl eu rhoncus lacinia, eros nisl tempus sem, at vulputate ante tellus sit amet lorem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum at sapien at lorem interdum tempus convallis vitae dolor. Donec in pretium arcu. Pellentesque quis vestibulum mauris, id iaculis mi. Curabitur at ex a ex luctus sollicitudin. Donec sodales, dui nec consectetur maximus, augue orci hendrerit nunc, in imperdiet nisl elit nec eros. Vivamus posuere urna lectus, sit amet sollicitudin ipsum gravida vitae. Nullam ut mi orci. Integer posuere massa tincidunt, tincidunt nulla sed, auctor orci. Pellentesque quis eros non urna ultricies egestas ac id massa. Pellentesque ac eros nec lorem feugiat dignissim."),
        ]);
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService().favoritar(context, widget.carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);

    if (response.ok) {
      EventBus.get(context).senEvent(CarroEvent("carro_deletado", carro.tipo));
      alert(context, "Carro excluído com sucesso!", callback: () {
        Navigator.pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  _onClickVideoUrlLauncher(BuildContext context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      launch(carro.urlVideo);
    } else {
      alert(context, "O carro não possui vídeo");
    }
  }

  _onClickVideoVideoPlayer(BuildContext context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      push(context, VideoPage(carro));
    } else {
      alert(context, "O carro não possui vídeo");
    }
  }

  _onClickMapa(BuildContext context) {
    if (carro.latitude != null &&
        carro.latitude.isNotEmpty &&
        carro.longitude != null &&
        carro.longitude.isNotEmpty) {
      push(context, MapaPage(carro));
    } else {
      alert(context, "O carro não possui lat/long cadastrada");
    }
  }
}
