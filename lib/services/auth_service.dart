// import 'package:dio/dio.dart';
// import 'package:jiwaapp_task7/constant/api_constant.dart';
// import 'package:jiwaapp_task7/model/user_model.dart';
// import 'package:jiwaapp_task7/services/api_service.dart';
// import 'package:jiwaapp_task7/services/storage_service.dart';

// class AuthService {
//   final ApiService _apiService = ApiService();

//   // Login with email
//   Future<bool> login(String email) async {
//     try {
//       final response = await _apiService.post(
//         ApiConstants.login,
//         data: {'email': email},
//       );

//       if (response.statusCode == 200 && response.data['success'] == true) {
//         // Email exists, user should enter PIN
//         return true;
//       }
//       return false;
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 404) {
//         // Email not found, user should register
//         return false;
//       }
//       rethrow;
//     }
//   }

//   // PIN login
//   Future<Map<String, dynamic>> pinLogin(String email, String pin) async {
//     try {
//       final response = await _apiService.post(
//         ApiConstants.pinLogin,
//         data: {
//           'email': email,
//           'pin': pin,
//         },
//       );

//       if (response.statusCode == 200 && response.data['success'] == true) {
//         final token = response.data['data']['token'];
//         final user = UserModel.fromJson(response.data['data']['user']);
        
//         // Save token and user to local storage
//         await StorageService.setToken(token);
//         await StorageService.setUser(user);
        
//         return {
//           'success': true,
//           'user': user,
//         };
//       }
      
//       return {
//         'success': false,
//         'message': response.data['message'] ?? 'Unknown error occurred',
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': e.toString(),
//       };
//     }
//   }

//   // Verify OTP
//   Future<bool> verifyOtp(String email, String otp) async {
//     try {
//       final response = await _apiService.post(
//         ApiConstants.verifyOtp,
//         data: {
//           'email': email,
//           'otp': otp,
//         },
//       );

//       return response.statusCode == 200 && response.data['success'] == true;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Register user
//   Future<Map<String, dynamic>> register({
//     required String name,
//     required String email,
//     required String gender,
//     required String dateOfBirth,
//     required String region,
//     required String job,
//     required String phoneNumber,
//     String? referralCode,
//   }) async {
//     try {
//       final response = await _apiService.post(
//         ApiConstants.register,
//         data: {
//           'name': name,
//           'email': email,
//           'gender': gender,
//           'date_of_birth': dateOfBirth,
//           'region': region,
//           'job': job,
//           'phone_number': phoneNumber,
//           'referral_code': referralCode,
//         },
//       );

//       if (response.statusCode == 200 && response.data['success'] == true) {
//         return {
//           'success': true,
//           'message': response.data['message'],
//         };
//       }
      
//       return {
//         'success': false,
//         'message': response.data['message'] ?? 'Registration failed',
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': e.toString(),
//       };
//     }
//   }

//   // Create PIN
//   Future<bool> createPin(String email, String pin) async {
//     try {
//       final response = await _apiService.post(
//         ApiConstants.createPin,
//         data: {
//           'email': email,
//           'pin': pin,
//         },
//       );

//       return response.statusCode == 200 && response.data['success'] == true;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Get current user info
//   Future<UserModel?> getMe() async {
//     try {
//       final response = await _apiService.get(ApiConstants.me);
      
//       if (response.statusCode == 200 && response.data['success'] == true) {
//         return UserModel.fromJson(response.data['data']);
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   // Logout
//   Future<bool> logout() async {
//     try {
//       final response = await _apiService.post(ApiConstants.logout);
      
//       if (response.statusCode == 200) {
//         await StorageService.clearAll();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Get user from local storage
//   UserModel? getStoredUser() {
//     return StorageService.getUser();
//   }

//   // Check if user is logged in
//   bool isLoggedIn() {
//     return StorageService.isLoggedIn();
//   }
// }