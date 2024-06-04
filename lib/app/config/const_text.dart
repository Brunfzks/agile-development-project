import 'package:agile_development_project/app/config/const_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstText {
  static TextStyle welcomeText = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.complementaryColor,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  ));

  static TextStyle welcomeTextNegative = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.secondaryColor,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ));

  static TextStyle h1 = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.complementaryColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  ));

  static TextStyle textList = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  ));

  static TextStyle h1Black = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.primaryColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ));

  static TextStyle h2 = GoogleFonts.roboto(
      textStyle: const TextStyle(
    color: ConstColors.primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  ));

  static TextStyle formFieldText = GoogleFonts.roboto(
    color: ConstColors.secondaryColor,
    wordSpacing: 0.5,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
