// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiwaapp_task7/model/user_model.dart';
// import 'package:jiwaapp_task7/routes/app_routes.dart';
// import 'package:jiwaapp_task7/services/auth_service.dart';

// class AuthController extends GetxController {
//   final AuthService _authService = AuthService();
  
//   final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
//   final RxBool isLoading = false.obs;
//   final RxString error = ''.obs;
//   final RxString currentEmail = ''.obs;
//   final RxBool userExists = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     checkLoginStatus();
//   }

//   // Check if user is already logged in
//   Future<void> checkLoginStatus() async {
//     isLoading.value = true;
//     try {
//       if (_authService.isLoggedIn()) {
//         currentUser.value = _authService.getStoredUser();
        
//         // Verify token and get updated user info
//         final user = await _authService.getMe();
//         if (user != null) {
//           currentUser.value = user;
//         } else {
//           // Token might be invalid, log out
//           await logout();
//         }
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Login with email
//   Future<bool> login(String email) async {
//     isLoading.value = true;
//     error.value = '';
    
//     try {
//       currentEmail.value = email;
//       final exists = await _authService.login(email);
//       userExists.value = exists;
//       return exists;
//     } catch (e) {
//       error.value = e.toString();
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // PIN login
//   Future<bool> pinLogin(String pin) async {
//     isLoading.value = true;
//     error.value = '';
    
//     try {
//       final result = await _authService.pinLogin(currentEmail.value, pin);
      
//       if (result['success']) {
//         currentUser.value = result['user'];
//         Get.offAllNamed(AppRoutes.profile);
//         return true;
//       } else {
//         error.value = result['message'];
//         return false;
//       }
//     } catch (e) {
//       error.value = e.toString();
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Verify OTP
//   Future<bool> verifyOtp(String otp) async {
//     isLoading.value = true;
//     error.value = '';
    
//     try {
//       final verified = await _authService.verifyOtp(currentEmail.value, otp);
      
//       if (verified) {
//         Get.offNamed(AppRoutes.register);
//         return true;
//       } else {
//         error.value = 'Invalid OTP code';
//         return false;
//       }
//     } catch (e) {
//       error.value = e.toString();
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Register user
//   Future<bool> register({
//     required String name,
//     required String gender,
//     required String dateOfBirth,
//     required String region,
//     required String job,
//     required String phoneNumber,
//     String? referralCode,
//   }) async {
//     isLoading.value = true;
//     error.value = '';
    
//     try {
//       final result = await _authService.register(
//         name: name,
//         email: currentEmail.value,
//         gender: gender,
//         dateOfBirth: dateOfBirth,
//         region: region,
//         job: job,
//         phoneNumber: phoneNumber,
//         referralCode: referralCode,
//       );
      
//       if (result['success']) {
//         Get.toNamed(AppRoutes.createPin);
//         return true;
//       } else {
//         error.value = result['message'];
//         return false;
//       }
//     } catch (e) {
//       error.value = e.toString();
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Create PIN
//   Future<bool> createPin(String pin) async {
//     isLoading.value = true;
//     error.value = '';
    
//     try {
//       final success = await _authService.createPin(currentEmail.value, pin);
      
//       if (success) {
//         // After PIN creation, login with the new credentials
//         await pinLogin(pin);
//         return true;
//       } else {
//         error.value = 'Failed to create PIN';
//         return false;
//       }
//     } catch (e) {
//       error.value = e.toString();
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Logout
//   Future<void> logout() async {
//     isLoading.value = true;
    
//     try {
//       await _authService.logout();
//       currentUser.value = null;
//       Get.offAllNamed(AppRoutes.home);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Clear error message
//   void clearError() {
//     error.value = '';
//   }
// }
