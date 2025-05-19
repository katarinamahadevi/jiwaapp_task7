import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/controller/cart_controller.dart';
import 'package:jiwaapp_task7/controller/login_controller.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/controller/profile_controller.dart';
import 'package:jiwaapp_task7/controller/register_controller.dart';
import 'package:jiwaapp_task7/services/address_service.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';
import 'package:jiwaapp_task7/services/menu_service.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // SERVICE
    Get.put(StorageService(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(MenuService(), permanent: true);
    Get.lazyPut<AddressService>(() => AddressService(Get.find<ApiClient>()));
    Get.put(CartService(), permanent: true);

    // CONTROLLER
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.put(AddressController());
    Get.lazyPut<MenuItemController>(() => MenuItemController());
    Get.lazyPut<CartController>(() => CartController());

  }
}
