import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'package:jiwaapp_task7/services/forget_pin_service.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_pin_forgetpin.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_verifyotp_forgetpin.dart';

class ForgetPinController extends GetxController {
  var isVerifyingOtp = false.obs;
  var isResendingOtp = false.obs;
  var errorMessage = ''.obs;

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  var isNavigating = false.obs;

  Future<void> forgotPin(String email) async {
    try {
      errorMessage.value = '';
      final result = await ForgetPinService().forgotPin(email);
      if (result['status'] == 'success') {
        user.value = UserModel(
          id: 0,
          name: 'name',
          email: email,
          createdAt: 'createdAt',
          updatedAt: 'updatedAt',
          gender: 'gender',
          dateOfBirth: 'dateOfBirth',
          region: 'region',
          job: 'job',
          phoneNumber: 'phoneNumber',
          referralCode: 'referralCode',
        );

        print('Navigasi ke modal OTP...');

        Future.delayed(Duration(milliseconds: 1500), () {
          Get.bottomSheet(
            backgroundColor: Colors.white,
            ModalBottomVerifyOTPForgetPin(email: email),
            isScrollControlled: true,
          );
        });
      } else {
        errorMessage.value = result['message'] ?? 'Gagal mengirim OTP';
        throw Exception(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    }
  }

  Future<void> resendOtp(String email) async {
    if (email.isEmpty) {
      errorMessage.value = 'Email tidak boleh kosong';
      throw Exception(errorMessage.value);
    }

    try {
      isResendingOtp.value = true;
      errorMessage.value = '';
      await forgotPin(email);
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isResendingOtp.value = false;
    }
  }

  Future<bool> verifyOtpResetPin(String email, String otp) async {
    try {
      isVerifyingOtp.value = true;
      errorMessage.value = '';

      final result = await ForgetPinService().verifyOtpResetPin(email, otp);
      if (result['status'] == true) {
        user.value = UserModel(
          id: 0,
          name: 'name',
          email: email,
          createdAt: 'createdAt',
          updatedAt: 'updatedAt',
          gender: 'gender',
          dateOfBirth: 'dateOfBirth',
          region: 'region',
          job: 'job',
          phoneNumber: 'phoneNumber',
          referralCode: 'referralCode',
        ); 
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'OTP tidak valid';
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  Future<void> verifyOtpAndShowResetPin(
    String email,
    String otp,
    BuildContext context,
  ) async {
    if (isNavigating.value) return;
    isNavigating.value = true;

    try {
      print("Verify OTP: $otp");
      bool result = await verifyOtpResetPin(email, otp);
      print("Verify OTP Result: $result");

      if (result) {
        Navigator.pop(context);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder:
                (context) => ModalBottomPinForgetpin(
                  title: 'Reset PIN',
                  subtitle: 'Masukan 6 angka PIN baru untuk reset PIN kamu',
                  onPinComplete: (pin) async {
                    print("PIN entered: $pin");
                    bool resetSuccess = await resetPin(pin);
                    print("Reset PIN result: $resetSuccess");

                    Navigator.pop(context);
                    Get.toNamed('/login');
                  },
                ),
          );
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage.value)));
      }
    } catch (e) {
      print("Error during OTP verification: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    } finally {
      isNavigating.value = false;
    }
  }

  Future<bool> resetPin(String pin) async {
    try {
      errorMessage.value = '';
      final email = user.value?.email ?? '';
      if (email.isEmpty) {
        errorMessage.value = 'Email tidak ditemukan';
        return false;
      }

      final result = await ForgetPinService().resetPin(email, pin);
      if (result['status'] == true) {
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Gagal reset PIN';
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    }
  }
}
