import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData brightTheme = ThemeData(
  primarySwatch: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.openSansTextTheme()
);

const Map<String, Color> TYPE_COLORS = {
  "normal": Colors.orange,
  "fightning": Colors.brown,
  "flying": Colors.teal,
  "poison": Colors.deepPurple,
  "ground": Colors.brown,
  "rock": Colors.grey,
  "bug": Colors.lime,
  "ghost": Colors.purple,
  "steel": Colors.blueGrey,
  "fire": Colors.red,
  "water": Colors.blue,
  "grass": Colors.green,
  "electric": Colors.yellow,
  "ice": Colors.cyan,
  "dragon": Colors.cyan,
  "dark": Colors.deepPurple,
  "fairy": Colors.pink
};

enum MyColors {
  BLACK
}

extension MyColorsPallet on MyColors
{
  Color get() {
    switch(this) {
      case MyColors.BLACK:
        return Color(0xFFFF2b292c);
      default:
        return Colors.white;  
    }
  }
}


enum MyTypography {
  SMALL,
  MEDIUM,
  BIG
}

extension MyTypographyPallet on MyTypography
{
  TextStyle get() {
    switch(this) {
      case MyTypography.SMALL:  
        return TextStyle(fontSize: 12.0);
      case MyTypography.MEDIUM:
        return TextStyle(fontSize: 16.0);
       case MyTypography.BIG:
        return TextStyle(fontSize: 24.0);
      default:
        return TextStyle(fontSize: 12.0);
    }
  }
} 
