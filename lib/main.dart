import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiwaapp_task7/pages/add_to_cart_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/onboarding_page.dart';
import 'package:jiwaapp_task7/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.lexendDecaTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Jiwa Coffee App',
      home: AddToCartPage(),
    );
  }
}
