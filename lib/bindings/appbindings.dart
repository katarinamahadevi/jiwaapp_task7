import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/login_controller.dart';
import 'package:jiwaapp_task7/controller/profile_controller.dart';
import 'package:jiwaapp_task7/controller/register_controller.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

 // DAFTARIN CONTROLLER
 
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(StorageService(), permanent: true);
    Get.put(AuthService(), permanent: true);
        
    // Controllers
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}