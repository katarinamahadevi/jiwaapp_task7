import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/model/referral_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class ReferralService {
  final Dio _dio = ApiClient().dio;
  final StorageService _storageService = StorageService();

  Future<ReferralModel> getReferralData() async {
    try {
      final token = await _storageService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _dio.get(
        '/auth/referred-friends',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        // Debug: Print raw response data
        print('Raw API Response: ${response.data}');
        print('Response Type: ${response.data.runtimeType}');
        
        // Check if response.data is valid
        if (response.data == null) {
          print('Response data is null');
          throw Exception('No data received from server');
        }
        
        final referralModel = ReferralModel.fromJson(response.data);
        print('Parsed ReferralModel: $referralModel');
        print('Friends count: ${referralModel.friends?.length ?? 0}');
        print('Total: ${referralModel.total}');
        
        return referralModel;
      } else {
        throw Exception('Failed to fetch referred friends');
      }
    } on DioException catch (e) {
      print('DioException: ${e.toString()}');
      print('Response data: ${e.response?.data}');
      
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Referred friends not found');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('General Exception: ${e.toString()}');
      throw Exception('Unexpected error: $e');
    }
  }
}