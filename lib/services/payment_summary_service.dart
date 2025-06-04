import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:dio/dio.dart';

class PaymentSummaryService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> fetchPaymentSummary() async {
    try {
      final response = await _apiClient.dio.get('/auth/cart/summary');
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch payment summary',
      );
    }
  }
  
  Future<Map<String, dynamic>> fetchPaymentSummaryByOrderId(int orderId) async {
    try {
      final response = await _apiClient.dio.get('/auth/orders/$orderId/summary');
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch payment summary for order',
      );
    }
  }
}
