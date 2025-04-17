import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jiwa Coffee App',
      home: HomePage(),
    );
  }
}
