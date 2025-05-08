// import 'package:get/get.dart';
// import 'package:jiwaapp_task7/model/user_model.dart';
// import 'package:jiwaapp_task7/services/auth_service.dart';

// class UserController extends GetxController {
//   final AuthService _authService = AuthService();
  
//   final Rx<UserModel?> user = Rx<UserModel?>(null);
//   final RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserProfile();
//   }

//   Future<void> fetchUserProfile() async {
//     isLoading.value = true;
    
//     try {
//       final userData = await _authService.getMe();
//       if (userData != null) {
//         user.value = userData;
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }