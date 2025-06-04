import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/model/order_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';

class OrderService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  Future<Response> getOrders({int page = 1, String? type}) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.get(
        '/auth/order',
        queryParameters: {'page': page},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder({
    required int addressId,
    required String orderType,
    required String courier,
    required double deliveryFee,
    required List<Map<String, dynamic>> items,
    String? voucherCode,
    bool useJiwaPoints = false,
    String? notes,
  }) async {
    final token = await _storageService.getToken();

    int subtotalPrice = 0;
    for (var item in items) {
      subtotalPrice += (item['price'] as int) * (item['quantity'] as int);
    }
    int totalPrice = subtotalPrice + deliveryFee.toInt();
    final orderData = <String, dynamic>{
      'order_type': orderType,
      'subtotal_price': subtotalPrice,
      'total_price': totalPrice,
      'items': items,
    };
    if (orderType == 'Delivery') {
      orderData['address_id'] = addressId;
      orderData['courier'] = courier;
      orderData['delivery_fee'] = deliveryFee.toInt();
    } else {
      orderData['address_id'] = null;
      orderData['courier'] = null;
      orderData['delivery_fee'] = 0;
      orderData['total_price'] = subtotalPrice;
    }

    final response = await _apiClient.dio.post(
      '/auth/order',
      data: orderData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = response.data;
      if (responseData != null && responseData['order'] != null) {
        return OrderModel.fromJson(responseData['order']);
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
    } else {
      throw Exception('Failed to create order: ${response.statusMessage}');
    }
  }

  Future<OrderModel> getOrderById(int orderId) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.get(
        '/auth/order/$orderId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final orderData = response.data['order'] ?? response.data;
        return OrderModel.fromJson(orderData);
      } else {
        throw Exception(
          'Failed to get order details: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching order details: $e');
    }
  }

  Future<Response> generatePayment(int orderId) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.post(
        '/auth/payment/generate',
        data: {'order_id': orderId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to generate payment: $e');
    }
  }

  Future<Response> cancelPayment(int orderId) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiClient.dio.post(
        '/auth/payment/cancel',
        data: {'order_id': orderId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to cancel payment: $e');
    }
  }
}
