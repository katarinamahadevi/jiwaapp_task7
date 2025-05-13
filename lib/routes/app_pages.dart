import 'package:get/get.dart';
import 'package:jiwaapp_task7/pages/auth_page/login_page.dart';
import 'package:jiwaapp_task7/pages/auth_page/pin_verification_login_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.pinVerification,
      page: () => PinVerificationLoginPage(),
    ),
     GetPage(
      name: AppRoutes.homepage,
      page: () => HomePage(),
    ),
  ];
}
