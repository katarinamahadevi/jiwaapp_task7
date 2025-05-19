import 'package:jiwaapp_task7/model/category_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';

class MenuService {
  final ApiClient _apiClient = ApiClient();

  Future<List<CategoryModel>> fetchAllMenus() async {
    try {
      final response = await _apiClient.dio.get('/auth/menus');
      final data = response.data['data'] as List;

      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load menus: $e');
    }
  }

  Future<CategoryModel> fetchMenuByCategory(int categoryId) async {
    try {
      final response = await _apiClient.dio.get('/auth/menus/$categoryId');
      final data = response.data['data'];

      return CategoryModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load category menu: $e');
    }
  }
}
