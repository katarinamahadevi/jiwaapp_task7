import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jiwaapp_task7/pages/pin_verification_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> bannerImages = [
    'assets/banner/banner1.jpg',
    'assets/banner/banner2.jpg',
    'assets/banner/banner3.jpg',
  ];

  final TextEditingController emailController = TextEditingController();
  bool isChecked = false;
  bool isButtonEnabled = false;

  void validateForm() {
    String email = emailController.text.trim();
    final emailRegex = RegExp(r'^.+@.+\..+$'); 
    setState(() {
      isButtonEnabled = emailRegex.hasMatch(email) && isChecked;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.3,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 4),
            ),
            items:
                bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  );
                }).toList(),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Silahkan masuk dengan alamat email yang terdaftar. Pastikan email kamu aktif.',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Alamat Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                            validateForm();
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color:
                                isChecked
                                    ? BaseColors.primary
                                    : Colors.transparent,
                            border: Border.all(color: BaseColors.greyText),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:
                              isChecked
                                  ? Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.black87),
                            children: [
                              const TextSpan(
                                text: 'Dengan masuk kamu menyetujui ',
                              ),
                              TextSpan(
                                text:
                                    'Syarat & Ketentuan dan kebijakan Privasi',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const TextSpan(text: ' Jiwa+'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap:
                        isButtonEnabled
                            ? () {
                              print(
                                'Masuk dengan email: ${emailController.text}',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PinVerificationPage(),
                                ),
                              );
                            }
                            : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color:
                            isButtonEnabled
                                ? BaseColors.primary
                                : BaseColors.border,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
