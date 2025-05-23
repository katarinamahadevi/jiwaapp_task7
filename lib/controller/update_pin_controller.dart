import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/pages/auth_page/login_page.dart';
import 'package:jiwaapp_task7/services/update_pin_service.dart';
import 'package:jiwaapp_task7/services/storage_service.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_pin_updatepin.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_verifyotp_updatepin.dart';

class UpdatePinController extends GetxController {
  final UpdatePinService _updatePinService = UpdatePinService();
  final StorageService _storageService = StorageService();

  final isLoading = false.obs;

  String? _cachedEmail;

  Future<void> sendOtp({required String email}) async {
    print("Sending OTP to email: $email"); 

    isLoading.value = true;
    try {
      await _updatePinService.sendOtpChangePin(email: email);
      _cachedEmail = email;
      Get.bottomSheet(
        backgroundColor: Colors.white,
        ModalBottomVerifyOTPUpdatePin(email: email),
        isScrollControlled: true,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    if (_cachedEmail == null) {
      Get.snackbar("Error", "Email tidak ditemukan.");
      return;
    }

    isLoading.value = true;
    try {
      await _updatePinService.verifyOtpChangePin(
        email: _cachedEmail!,
        otp: otp,
      );
      Get.back(); 
      Get.bottomSheet(
        backgroundColor: Colors.white,
        ModalBottomPinUpdatePin(),
        isScrollControlled: true,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePin({required String newPin}) async {
    if (_cachedEmail == null) {
      Get.snackbar("Error", "Email tidak ditemukan.");
      return;
    }

    isLoading.value = true;
    try {
      await _updatePinService.changePin(email: _cachedEmail!, newPin: newPin);

      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
