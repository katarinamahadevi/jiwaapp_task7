import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/services/api_client.dart';

class CartService {
  final ApiClient _apiClient = ApiClient();
  final String _basePath = '/auth/cart';

  // Get all cart items
  Future<Response> getCartItems() async {
    try {
      final response = await _apiClient.dio.get(_basePath);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch cart items: ${e.response?.data ?? e.message}');
    }
  }

  // Add item to cart
  Future<Response> addToCart(Map<String, dynamic> cartData) async {
    try {
      final response = await _apiClient.dio.post(_basePath, data: cartData);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to add item to cart: ${e.response?.data ?? e.message}');
    }
  }

  // Get single cart item by ID
  Future<Response> getCartItemById(int id) async {
    try {
      final response = await _apiClient.dio.get('$_basePath/$id');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to fetch cart item: ${e.response?.data ?? e.message}');
    }
  }

  // Delete cart item by ID
  Future<Response> deleteCartItem(int id) async {
    try {
      final response = await _apiClient.dio.delete('$_basePath/$id');
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to delete cart item: ${e.response?.data ?? e.message}');
    }
  }
}
