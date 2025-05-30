import 'package:jiwaapp_task7/model/courier_model.dart';
import 'package:jiwaapp_task7/services/api_client.dart';

class CourierService {
  final ApiClient _apiClient = ApiClient();

  Future<List<CourierModel>> fetchCouriers() async {
    try {
      final response = await _apiClient.dio.get('/auth/couriers');

      if (response.statusCode == 200) {
        final List data = response.data['couriers'];
        return data.map((json) => CourierModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load couriers: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching couriers: $e');
    }
  }
}
