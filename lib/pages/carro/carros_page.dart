import 'dart:async';

import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  StreamSubscription<Event> subscription;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.tipo);

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e) {
      print("Event $e");
      CarroEvent carroEvent = e;
      if(carroEvent.tipo == widget.tipo) {
        _bloc.fetch(widget.tipo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(onRefresh: _onRefresh, child: CarrosListView(snapshot.data),);
      },
    );
  }


  @override
  bool get wantKeepAlive => true;

  @override
  dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(widget.tipo);
  }
}
