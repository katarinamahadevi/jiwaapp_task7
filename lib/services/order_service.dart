import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class OrderService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  Future<Response> getOrders({int page = 1}) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.get(
        '/auth/order',
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createOrder(Map<String, dynamic> orderData) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.post(
        '/auth/order',
        data: orderData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
