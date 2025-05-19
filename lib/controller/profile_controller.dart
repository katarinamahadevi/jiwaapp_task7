import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:jiwaapp_task7/pages/auth_page/onboarding_page.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void copyReferralCode() {
    if (user.value?.referralCode != null) {
      Clipboard.setData(ClipboardData(text: user.value!.referralCode));
      Get.snackbar(
        'Success',
        'Kode disalin ke clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    }
  }

  void shareReferralCode() {
    Share.share(
      'Hai, coba order menu favoritmu pakai JIWA+, yuk! Gunakan kode referral saya: ${user.value?.referralCode ?? ""}',
    );
  }

  Future<void> openJiwaCare() async {
    final Uri jiwaCareAppUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );
    final Uri jiwaCareWebUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );

    try {
      bool launched = await launchUrl(
        jiwaCareAppUri,
        mode: LaunchMode.externalNonBrowserApplication,
      );

      if (!launched) {
        launched = await launchUrl(
          jiwaCareWebUri,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        Get.snackbar(
          'Error',
          'Tidak dapat membuka WhatsApp',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
        );
      }
    } catch (e) {
      print('Error membuka WhatsApp: $e');
      Get.snackbar(
        'Error',
        'Error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  //UNTUK MENGAMBIL DATA USER YANG LOGIN
  Future<void> fetchUserData() async {
    try {
      final userData = await _authService.getCurrentUser();
      user.value = userData;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error fetching user data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  //UNTUK LOGOUT
  Future<void> logout() async {
    try {
      await _authService.logout();
      Get.offAll(() => OnboardingPage());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error logging out: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  //UNTUK UPDATE PROFILE USER (TAPI BELUM BISA)
  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    isLoading.value = true;

    try {
      await _authService.updateUserProfile(userData);
      await fetchUserData();

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error updating profile: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // UNTUK MENGHAPUS AKUN
  Future<void> deleteUserProfile() async {
    isLoading.value = true;
    try {
      await _authService.deleteUserProfile();
      Get.offAll(() => OnboardingPage());

      Get.snackbar(
        'Success',
        'Akun Anda berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus akun: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }
}
