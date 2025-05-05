import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/pages/register_page.dart';
import 'dart:async';

class OtpVerificationBottomSheet extends StatefulWidget {
  const OtpVerificationBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const OtpVerificationBottomSheet(),
    );
  }

  @override
  State<OtpVerificationBottomSheet> createState() =>
      _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState
    extends State<OtpVerificationBottomSheet> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;

  // Timer state for countdown
  int _secondsRemaining = 29;
  bool _canResendOtp = false;

  @override
  void initState() {
    super.initState();
    // Ensure first field is focused after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_otpFocusNodes.isNotEmpty) {
        _otpFocusNodes[0].requestFocus();
      }
    });

    // Start countdown timer
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
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
    // Clean up controllers and focus nodes
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _checkOtpAndNavigate() {
    final allFilled = _otpControllers.every((c) => c.text.isNotEmpty);
    if (allFilled) {
      // Get the complete OTP code
      final otp = _otpControllers.map((c) => c.text).join();

      // Here you would typically validate the OTP with your backend
      // For this example, we'll just navigate
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RegisterPage()),
      );
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
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header row
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Masukan OTP yang dikirimkan ke email kamu',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),

          const SizedBox(height: 24),
          // OTP Input Fields
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
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  // Simpler input handling to avoid focus issues
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    // Handle forward navigation (auto-advance to next field)
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        _otpFocusNodes[index + 1].requestFocus();
                      } else {
                        // Hide keyboard and check OTP
                        FocusScope.of(context).unfocus();
                        _checkOtpAndNavigate();
                      }
                    }
                  },
                  // Listen for text editing to handle backspace
                  onEditingComplete: () {
                    // Check if the field is empty and we need to go back
                    if (_otpControllers[index].text.isEmpty && index > 0) {
                      _otpFocusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),

          const SizedBox(height: 40),
          // Resend OTP timer
          GestureDetector(
            onTap:
                _canResendOtp
                    ? () {
                      // Handle resend OTP here
                      setState(() {
                        _secondsRemaining = 29;
                        _canResendOtp = false;
                      });
                      _startCountdownTimer();
                    }
                    : null,
            child: RichText(
              text: TextSpan(
                text: 'Kirim ulang OTP setelah ',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                children: [
                  TextSpan(
                    text: '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: _canResendOtp ? Colors.green : Colors.black,
                      fontWeight:
                          _canResendOtp ? FontWeight.bold : FontWeight.normal,
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

void showVerifyOTPBottomSheet(BuildContext context) {
  OtpVerificationBottomSheet.show(context);
}
