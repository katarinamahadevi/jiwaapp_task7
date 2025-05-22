import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class ForgetPinService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  String _handleError(DioException error) {
    String errorMessage = 'Something went wrong. Please try again.';

    if (error.response != null) {
      if (error.response!.data != null) {
        if (error.response!.data is Map &&
            error.response!.data['message'] != null) {
          errorMessage = error.response!.data['message'];
        } else if (error.response!.data is String) {
          errorMessage = error.response!.data;
        }
      } else {
        switch (error.response!.statusCode) {
          case 400:
            errorMessage = 'Bad request';
            break;
          case 401:
            errorMessage = 'Unauthorized';
            break;
          case 403:
            errorMessage = 'Forbidden';
            break;
          case 404:
            errorMessage = 'Not found';
            break;
          case 500:
            errorMessage = 'Server error';
            break;
        }
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection timeout';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Receive timeout';
    } else if (error.type == DioExceptionType.unknown) {
      errorMessage = 'Network error';
    }

    return errorMessage;
  }

  // UNTUK MEMINTA RESET PIN (FORGOT PIN)
  Future<Map<String, dynamic>> forgotPin(String email) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/forgot-pin',
        data: {'email': email},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // UNTUK VERIFIKASI OTP SEBELUM RESET PIN
  Future<Map<String, dynamic>> verifyOtpResetPin(
    String email,
    String otp,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/verify-otp-reset-pin',
        data: {'email': email, 'otp': otp},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // UNTUK MELAKUKAN RESET PIN
  Future<Map<String, dynamic>> resetPin(String email, String pin) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/reset-pin',
        data: {'email': email, 'new_pin_code': pin},
      );
      if (response.data['token'] != null) {
        await _storageService.saveToken(response.data['token']);
      }
      if (response.data['user'] != null) {
        await _storageService.saveUserData(json.encode(response.data['user']));
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
