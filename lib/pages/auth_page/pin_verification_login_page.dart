import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/login_controller.dart';
import 'package:jiwaapp_task7/controller/forget_pin_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class PinVerificationLoginPage extends StatefulWidget {
  @override
  _PinVerificationLoginPageState createState() =>
      _PinVerificationLoginPageState();
}

class _PinVerificationLoginPageState extends State<PinVerificationLoginPage> {
  final int pinLength = 6;
  String currentPin = '';
  String email = '';
  bool isLoading = false;

  final TextEditingController _pinController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  final LoginController _loginController = Get.find<LoginController>();

  final pinController = Get.put(ForgetPinController());

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null && Get.arguments['email'] != null) {
      email = Get.arguments['email'];
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar(
          'Error',
          'Email tidak ditemukan, silakan login ulang',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }

    _pinController.addListener(() {
      setState(() {
        currentPin = _pinController.text;
        if (currentPin.length == pinLength) {
          _verifyPin();
        }
      });
    });
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _verifyPin() {
    _focusNode.unfocus();
    final enteredPin = _pinController.text.trim();

    if (enteredPin.isEmpty || enteredPin.length < pinLength) {
      Get.snackbar(
        'Error',
        'PIN harus terdiri dari 6 angka',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _loginController.verifyPinLogin(email, enteredPin, _pinController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Masukkan PIN',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Masukkan 6 angka PIN kamu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pinLength,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          color:
                              index < currentPin.length
                                  ? BaseColors.primary
                                  : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (isLoading)
                    CircularProgressIndicator(color: BaseColors.primary),
                  Opacity(
                    opacity: 0,
                    child: Container(
                      width: 1,
                      height: 1,
                      child: TextField(
                        controller: _pinController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(pinLength),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lupa dengan PIN kamu?',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (email.isNotEmpty) {
                            pinController.forgotPin(email);
                          } else {
                            Get.snackbar("Error", "Email tidak boleh kosong");
                          }
                        },
                        child: Text(
                          'Kirim OTP',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
