import 'package:dio/dio.dart';
import 'package:jiwaapp_task7/model/notification_model.dart';
import 'api_client.dart';

class NotificationService {
  final ApiClient _apiClient;

  NotificationService(this._apiClient);

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final response = await _apiClient.dio.get('/auth/notification/info');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
