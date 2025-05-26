import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/controller/cart_controller.dart';
// import 'package:jiwaapp_task7/controller/cart_controller.dart';
import 'package:jiwaapp_task7/controller/login_controller.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/controller/forget_pin_controller.dart';
import 'package:jiwaapp_task7/controller/profile_controller.dart';
import 'package:jiwaapp_task7/controller/referral_controller.dart';
import 'package:jiwaapp_task7/controller/register_controller.dart';
import 'package:jiwaapp_task7/controller/update_pin_controller.dart';
import 'package:jiwaapp_task7/services/address_service.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';
import 'package:jiwaapp_task7/services/menu_service.dart';
import 'package:jiwaapp_task7/services/forget_pin_service.dart';
import 'package:jiwaapp_task7/services/referral_service.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';
import 'package:jiwaapp_task7/services/update_pin_service.dart';

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
    Get.put(ForgetPinService(), permanent: true);
    Get.put(UpdatePinService(), permanent: true);
    Get.put(ReferralService(), permanent: true);

    // CONTROLLER
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.put(ProfileController());
    Get.put(AddressController());
    Get.lazyPut<MenuItemController>(() => MenuItemController());
    Get.put(CartController());
    Get.lazyPut<ForgetPinController>(() => ForgetPinController());
    Get.put(UpdatePinController());
    Get.put(ReferralController());
  }
}
