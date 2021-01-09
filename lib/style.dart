import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData brightTheme = ThemeData(
  primarySwatch: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.openSansTextTheme()
);


enum MyTypography {
  SMALL,
  MEDIUM,
  BIG
}

extension Pallet on MyTypography
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
