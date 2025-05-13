import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/register_controller.dart';
import 'package:jiwaapp_task7/pages/auth_page/register_page.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'dart:async';

//MASUKIN OTP SEBELUM KE REGISTER PAGE

void showModalBottomVerifyOTPRegister(BuildContext context, {String? email}) {
  ModalBottomVerifyOTPRegister.show(context, email: email);
}

class ModalBottomVerifyOTPRegister extends StatefulWidget {
  final String? email;

  const ModalBottomVerifyOTPRegister({super.key, this.email});

  static void show(BuildContext context, {String? email}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ModalBottomVerifyOTPRegister(email: email),
    );
  }

  @override
  State<ModalBottomVerifyOTPRegister> createState() =>
      _ModalBottomVerifyOTPRegisterState();
}

class _ModalBottomVerifyOTPRegisterState
    extends State<ModalBottomVerifyOTPRegister> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 29;
  bool _canResendOtp = false;
  bool _isResendingOtp = false;
  bool _isVerifyingOtp = false;

  String _email = '';

  // API service
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    if (widget.email != null && widget.email!.isNotEmpty) {
      _email = widget.email!;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_otpFocusNodes.isNotEmpty) {
          _otpFocusNodes[0].requestFocus();
        }
      });

      _startCountdownTimer();
    }
  }

  void _startCountdownTimer() {
    _timer?.cancel();

    setState(() {
      _secondsRemaining = 29;
      _canResendOtp = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResendOtp = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _verifyOtpAndNavigate() async {
    final allFilled = _otpControllers.every((c) => c.text.isNotEmpty);
    if (!allFilled) return;

    final otp = _otpControllers.map((c) => c.text).join();

    if (_email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email tidak valid')));
      return;
    }

    setState(() {
      _isVerifyingOtp = true;
    });

    try {
      await _authService.verifyOtp(_email, otp);

      setState(() {
        _isVerifyingOtp = false;
      });

      Navigator.of(context).pop();

      if (!Get.isRegistered<RegisterController>()) {
        Get.put(RegisterController());
      }
      Get.to(() => RegisterPage(), arguments: {'email': _email});
    } catch (e) {
      setState(() {
        _isVerifyingOtp = false;
      });

      for (var controller in _otpControllers) {
        controller.clear();
      }

      if (_otpFocusNodes.isNotEmpty) {
        _otpFocusNodes[0].requestFocus();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResendOtp || _email.isEmpty) return;

    setState(() {
      _isResendingOtp = true;
    });

    try {
      await _authService.login(_email);

      setState(() {
        _isResendingOtp = false;
      });

      _startCountdownTimer();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Kode OTP telah dikirim ulang')));
    } catch (e) {
      setState(() {
        _isResendingOtp = false;
        _canResendOtp = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verifikasi Email Kamu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 18,
                  child: const Icon(Icons.close, size: 18, color: Colors.black),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Masukan OTP yang dikirimkan ke $_email',
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 60,
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: BaseColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        _otpFocusNodes[index + 1].requestFocus();
                      } else {
                        FocusScope.of(context).unfocus();
                        _verifyOtpAndNavigate();
                      }
                    } else if (value.isEmpty && index > 0) {
                      _otpFocusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),

          if (_isVerifyingOtp) ...[
            const SizedBox(height: 20),
            CircularProgressIndicator(color: BaseColors.primary),
          ],

          const SizedBox(height: 40),
          GestureDetector(
            onTap: _canResendOtp && !_isResendingOtp ? _resendOtp : null,
            child:
                _isResendingOtp
                    ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: BaseColors.primary,
                      ),
                    )
                    : RichText(
                      text: TextSpan(
                        text: 'Kirim ulang OTP setelah ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color:
                                  _canResendOtp
                                      ? BaseColors.primary
                                      : Colors.black,
                              fontWeight:
                                  _canResendOtp
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
