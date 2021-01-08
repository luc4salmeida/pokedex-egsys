import 'package:flutter/material.dart';
import 'package:pokedex_egsys/widgets/base_view.dart';

import '../controller/splash.dart';

class SplashScreenView extends WidgetView<SplashScreen, SplashScreenController> {
  SplashScreenView(SplashScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFFFdc221c),
            ),
          ),
          Center(
            child: Image.asset('assets/loading.gif')
          ),
        ],
      )
    );
  }
}
