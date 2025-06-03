import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiwaapp_task7/bindings/appbindings.dart';
import 'package:jiwaapp_task7/routes/app_pages.dart';
import 'package:jiwaapp_task7/routes/app_routes.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.lexendDecaTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Jiwa Coffee App',
      initialBinding: AppBindings(),
      home: SplashScreen(), 
      getPages: AppPages.pages,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); 

    try {
      final token = await _storageService.getToken();
      
      if (token != null && token.isNotEmpty) {
        try {
          await _authService.getCurrentUser();
          Get.offAllNamed(AppRoutes.homepage);
        } catch (e) {
          await _storageService.clearAll();
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            Text(
              'Jiwa Coffee App',
              style: GoogleFonts.lexendDeca(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}