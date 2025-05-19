import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/services/api_client.dart';

class CartService {
  final Dio _dio = ApiClient().dio;

  Future<Response> addToCart(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/auth/cart', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCartItems() async {
    try {
      final response = await _dio.get('/auth/cart');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCartItem(int cartId) async {
    try {
      final response = await _dio.delete('/auth/cart/$cartId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
