import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/referral_model.dart';
import 'package:jiwaapp_task7/services/referral_service.dart';

class ReferralController extends GetxController {
  final ReferralService _referralService = ReferralService();

  final Rx<ReferralModel?> _referralData = Rx<ReferralModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  ReferralModel? get referralData => _referralData.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  int get totalFriends => _referralData.value?.total ?? 0;

  List<ReferralByModel> get friendsList => _referralData.value?.friends ?? [];

  int get activeFriendsCount =>
      friendsList
          .where((friend) => friend.status.toLowerCase() == 'active')
          .length;

  int get inactiveFriendsCount =>
      friendsList
          .where((friend) => friend.status.toLowerCase() == 'inactive')
          .length;

  @override
  void onInit() {
    super.onInit();
    fetchReferralData();
  }

  Future<void> fetchReferralData() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      final data = await _referralService.getReferralData();
      _referralData.value = data;
    } catch (e) {
      _errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load referral data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchReferralData();
  }

  void clearError() {
    _errorMessage.value = '';
  }

  bool isFriendActive(ReferralByModel friend) {
    return friend.status.toLowerCase() == 'active';
  }

  String getFriendStatusText(ReferralByModel friend) {
    return isFriendActive(friend) ? 'Active' : 'Inactive';
  }
}
