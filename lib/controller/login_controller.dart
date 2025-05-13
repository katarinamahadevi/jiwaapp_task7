import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import '../pages/auth_page/pin_verification_login_page.dart';
import '../services/auth_service.dart';
import '../widgets/auth_page/modal_bottom_verifyotp.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxBool isChecked = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxBool isLoading = false.obs;

  final List<String> bannerImages = [
    'assets/banner/banner1.jpg',
    'assets/banner/banner2.jpg',
    'assets/banner/banner3.jpg',
  ];

  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateForm);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void validateForm() {
    String email = emailController.text.trim();
    final emailRegex = RegExp(r'^.+@.+\..+$');
    isButtonEnabled.value = emailRegex.hasMatch(email) && isChecked.value;
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
    validateForm();
  }

  Future<void> handleLogin() async {
    if (!isButtonEnabled.value) return;

    isLoading.value = true;
    String email = emailController.text.trim();

    try {
      await _authService.login(email);

      isLoading.value = false;
      Get.to(() => PinVerificationLoginPage(), arguments: {'email': email});
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e.toString();
      if (_isEmailNotRegistered(errorMessage)) {
        try {
          await _authService.sendOtp(email);
          if (Get.context != null) {
            showModalBottomVerifyOTPRegister(Get.context!, email: email);
          }

          Get.snackbar('OTP Terkirim', 'Kode OTP telah dikirim ke email Anda.');
        } catch (e) {
          Get.snackbar('Gagal Mengirim OTP', e.toString());
        }
      } else {
        Get.snackbar('Error', errorMessage);
      }
    }
  }

  bool _isEmailNotRegistered(String error) {
    return error.contains('not found') ||
        error.contains('tidak terdaftar') ||
        error.contains('not registered');
  }

  Future<void> verifyPinLogin(
    String email,
    String pin,
    TextEditingController pinController,
  ) async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email tidak ditemukan, silakan kembali dan login ulang.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authService.pinLogin(email, pin);
      isLoading.value = false;

      if (response['status'] == 'success') {
        Get.offAll(() => const ProfilePage());
        Get.snackbar(
          'Berhasil',
          'Login berhasil',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        pinController.clear();
        Get.snackbar(
          'Gagal',
          response['message'] ?? 'PIN salah atau tidak valid',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoading.value = false;
      pinController.clear();
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat memverifikasi PIN',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
