import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class PinVerificationPage extends StatefulWidget {
  @override
  _PinVerificationPageState createState() => _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
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
        // Menangkap tap dimanapun untuk memunculkan keyboard
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

                  // PIN indicators (circles)
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

                  // Hidden TextField untuk input
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
                          // Handle OTP request
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mengirim OTP ke nomor terdaftar'),
                            ),
                          );
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
    // Nonaktifkan focus untuk menutup keyboard
    _focusNode.unfocus();

    // Mock verification - in a real app, this would check against stored or API PIN
    Future.delayed(Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Verifikasi PIN: $currentPin')));

      // Reset controller untuk halaman berikutnya
      _pinController.clear();

      // Navigate to second verification page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPinVerificationPage(firstPin: currentPin),
        ),
      );
    });
  }
}

// Second verification page for 2FA
class SecondPinVerificationPage extends StatefulWidget {
  final String firstPin;

  const SecondPinVerificationPage({Key? key, required this.firstPin})
    : super(key: key);

  @override
  _SecondPinVerificationPageState createState() =>
      _SecondPinVerificationPageState();
}

class _SecondPinVerificationPageState extends State<SecondPinVerificationPage> {
  final int pinLength = 6;
  String currentPin = '';

  // Controller untuk TextField tersembunyi
  final TextEditingController _pinController = TextEditingController();
  // Focus node untuk mengelola focus keyboard
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
          'Konfirmasi PIN',
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
                    'Masukkan kembali 6 angka PIN kamu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 40),

                  // PIN indicators (circles)
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

                  // Hidden TextField untuk input
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
                        'Pastikan PIN yang kamu masukkan sama',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
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
      // Verifikasi apakah PIN sama dengan yang pertama
      if (currentPin == widget.firstPin) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('PIN berhasil dibuat!')));

        // Tampilkan dialog sukses
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('PIN berhasil dibuat!')));

        // Tampilkan dialog sukses
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );

        // Reset input
        setState(() {
          _pinController.clear();
        });
      }
    });
  }
}
