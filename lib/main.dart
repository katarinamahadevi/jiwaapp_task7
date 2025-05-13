import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiwaapp_task7/bindings/appbindings.dart';
import 'package:jiwaapp_task7/routes/app_pages.dart';
import 'package:jiwaapp_task7/routes/app_routes.dart';
import 'package:get/get.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.lexendDecaTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Jiwa Coffee App',
      // home: HomePage(),
      initialBinding: AppBindings(),
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
