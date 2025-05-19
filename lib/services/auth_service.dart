import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'dart:convert';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _tokenService = StorageService();

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

  //UNTUK LOGIN
  Future<Map<String, dynamic>> login(String email) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {'email': email},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK MEMASUKKAN PIN LOGIN
  Future<Map<String, dynamic>> pinLogin(String email, String pin) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/pin-login',
        data: {'email': email, 'pin_code': pin},
      );

      if (response.data['token'] != null) {
        await _tokenService.saveToken(response.data['token']);
      }

      if (response.data['user'] != null) {
        await _tokenService.saveUserData(json.encode(response.data['user']));
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK VERIFIKASI OTP REGISTER
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/verify-otp',
        data: {'email': email, 'otp': otp},
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK REGISTER
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/register',
        data: userData,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK MEMBUAT PIN REGISTER
  Future<Map<String, dynamic>> createPin(String email, String pin) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/create-pin',
        data: {'email': email, 'pin_code': pin},
      );

      if (response.data['token'] != null) {
        await _tokenService.saveToken(response.data['token']);
      }

      if (response.data['user'] != null) {
        await _tokenService.saveUserData(json.encode(response.data['user']));
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK GET USER
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiClient.dio.get('/auth/me');

      await _tokenService.saveUserData(json.encode(response.data['data']));

      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK LOGOUT
  Future<bool> logout() async {
    try {
      await _apiClient.dio.post('/auth/logout');
      await _tokenService.clearAll();
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK MENGIRIM OTP
  Future<void> sendOtp(String email) async {
    try {
      await _apiClient.dio.post('/auth/verify-otp', data: {'email': email});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK UPDATE PROFILE USER
  Future<Map<String, dynamic>> updateUserProfile(
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/edit-profile',
        data: userData,
      );

      if (response.data['data'] != null) {
        await _tokenService.saveUserData(json.encode(response.data['data']));
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //UNTUK HAPUS AKUN USER
  Future<Map<String, dynamic>> deleteUserProfile() async {
    try {
      final response = await _apiClient.dio.delete('/auth/delete-account');
      if (response.data['data'] != null) {
        await _tokenService.deleteToken();
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
