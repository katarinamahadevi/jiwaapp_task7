import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import '../pages/auth_page/pin_verification_login_page.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../widgets/auth_page/modal_bottom_verifyotp_register.dart';

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
  final StorageService _storageService = StorageService();

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateForm);
    checkAutoLogin();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

//NYIMPEN TOKEN DI LOKAL
  Future<void> checkAutoLogin() async {
    try {
      final token = await _storageService.getToken();
      
      if (token != null && token.isNotEmpty) {
        try {
          await _authService.getCurrentUser();
          Get.offAll(() => const HomePage());
          Get.snackbar(
            'Selamat Datang Kembali',
            'Login otomatis berhasil',
            snackPosition: SnackPosition.BOTTOM,
          );
        } catch (e) {
          await _storageService.clearAll();
          print('Token invalid, cleared: $e');
        }
      }
    } catch (e) {
      print('Error checking auto login: $e');
    }
  }

  //VALIDASI INPUT EMAIL MENGGUNAKAN .COM DAN @
  void validateForm() {
    String email = emailController.text.trim();
    final emailRegex = RegExp(r'^.+@.+\..+$');
    isButtonEnabled.value = emailRegex.hasMatch(email) && isChecked.value;
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
    validateForm();
  }

  //MEMVALIDASI APAKAH EMAIL TERDAFTAR/TIDAK JIKA IYA DIA KE PINVERIFICATIONLOGINPAGE, JIKA TIDAK KE MODALBOTTOMVERIFYOTPREGISTER
  Future<void> handleLogin() async {
    if (!isButtonEnabled.value) return;

    isLoading.value = true;
    final email = emailController.text.trim();

    try {
      final response = await _authService.login(email);
      isLoading.value = false;

      final isRegistered = response['is_registered'] as bool? ?? false;

      if (isRegistered) {
        Get.to(() => PinVerificationLoginPage(), arguments: {'email': email});
      } else {
        await _authService.sendOtp(email);
        if (Get.context != null) {
          showModalBottomVerifyOTPRegister(Get.context!, email: email);
        }
        Get.snackbar(
          'OTP Dikirim',
          'Silakan cek email Anda.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Login Gagal',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //VERIFIKASI PIN AKUN BENAR ATAU TIDAK
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
        Get.offAll(() => const HomePage());
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

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authService.logout();
      
      await _storageService.clearAll();
      
      Get.offAllNamed('/login'); 
      
      Get.snackbar(
        'Logout Berhasil',
        'Anda telah keluar dari aplikasi',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
}