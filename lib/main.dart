import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:carros/pages/splash_page.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create: (context) => EventBus(),
          dispose: (context, bus) => bus.dispose,
        ),
        Provider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white
        ),
        home: SplashPage(),
      ),
    );
  }
}