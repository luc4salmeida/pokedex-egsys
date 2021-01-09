import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/io/database.dart';
import 'package:pokedex_egsys/core/search_provider.dart';
import 'package:provider/provider.dart';
import 'style.dart';


import 'vmc/controller/splash.dart';
import 'vmc/controller/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => SearchProvider(database: Database()))
      ],
      child: MaterialApp(
        title: 'PokeDex',
        theme: brightTheme,
        initialRoute: SplashScreen.route,
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          HomeScreen.route: (context) => HomeScreen()
        },
      ),
    );
  }
}