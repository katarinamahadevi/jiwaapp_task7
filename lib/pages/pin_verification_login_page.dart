import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_verifyotp.dart';

class PinVerificationLoginPage extends StatefulWidget {
  @override
  _PinVerificationLoginPageState createState() =>
      _PinVerificationLoginPageState();
}

class _PinVerificationLoginPageState extends State<PinVerificationLoginPage> {
  final int pinLength = 6;
  String currentPin = '';

  // Controller untuk TextField tersembunyi
  final TextEditingController _pinController = TextEditingController();
  // Focus node untuk mengelola focus keyboard
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Listener untuk update UI saat input berubah
    _pinController.addListener(() {
      setState(() {
        currentPin = _pinController.text;
        // Jika PIN sudah lengkap, verifikasi
        if (currentPin.length == pinLength) {
          _verifyPin();
        }
      });
    });

    // Set focus ke field saat halaman dibuka
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
                          showModalBottomVerifyOTPRegister(context);
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

  void _verifyPin() {
    _focusNode.unfocus();

    Future.delayed(Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Berhasil: $currentPin')));

      _pinController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    });
  }
}
