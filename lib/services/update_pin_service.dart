import 'dart:convert';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class UpdatePinService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  Future<void> sendOtpChangePin({required String email}) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/send-otp-change-pin',
        data: {'email': email},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send OTP: ${response.statusMessage}');
      }
      await _storageService.saveUserData(jsonEncode({'email': email}));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtpChangePin({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/verify-otp-change-pin',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('OTP verification failed: ${response.statusMessage}');
      }

      if (response.data['user'] != null) {
        final user = UserModel.fromJson(response.data['user']);
        await _storageService.saveUserData(jsonEncode(user.toJson()));
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePin({
    required String email,
    required String newPin,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/change-pin',
        data: {
          'email': email,
          'new_pin_code': newPin,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change PIN: ${response.statusMessage}');
      }

      await _storageService.clearAll();
    } catch (e) {
      rethrow;
    }
  }
}
