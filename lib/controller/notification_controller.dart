import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/notification_model.dart';
import 'package:jiwaapp_task7/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService;

  NotificationController(this._notificationService);

  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _notificationService.fetchNotifications();
      notifications.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
