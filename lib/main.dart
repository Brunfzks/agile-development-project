import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/presenter/login/login.dart';
import 'package:agile_development_project/app/presenter/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: ConstColors.bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: ConstColors.secondaryColor,
        ),
        home: Login());
  }
}
