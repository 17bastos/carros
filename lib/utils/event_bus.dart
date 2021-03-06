import 'dart:async';
import 'package:provider/provider.dart';

class Event {

}

class EventBus {
  final _streamController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream;

  senEvent(Event event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }

  static EventBus get(context) {
    return Provider.of<EventBus>(context, listen: false);
  }
}