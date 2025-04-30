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
  String selectedCountry = 'Indonesia';
  String selectedDialCode = '+62';
  String selectedFlagAsset = 'assets/image/image_bendera_indonesia.png';
  final List<Map<String, String>> countries = [
    {
      'name': 'Afghanistan',
      'code': '+93',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Albania',
      'code': '+355',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Algeria',
      'code': '+213',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'American Samoa',
      'code': '+1684',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Indonesia',
      'code': '+62',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
  ];

  final TextEditingController phoneController = TextEditingController();
  bool isChecked = false;
  bool isButtonEnabled = false;

  void validateForm() {
    String phone = phoneController.text;
    setState(() {
      isButtonEnabled = phone.length >= 9 && isChecked;
    });
  }

  void showCountryPicker() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Masukkan nama negara',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return ListTile(
                      leading: Image.asset(country['flag']!, width: 32),
                      title: Text(country['name']!),
                      trailing: Text(country['code']!),
                      onTap: () {
                        setState(() {
                          selectedCountry = country['name']!;
                          selectedDialCode = country['code']!;
                          selectedFlagAsset = country['flag']!;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    phoneController.addListener(validateForm);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: CarouselSlider(
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
                    'Silahkan masuk dengan nomor ponsel yang terdaftar. Pastikan nomor kamu aktif.',
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
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: showCountryPicker,
                          child: Row(
                            children: [
                              Image.asset(selectedFlagAsset, width: 24),
                              SizedBox(width: 6),
                              Text(
                                selectedDialCode,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),

                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Nomor Ponsel',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
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
                                'Masuk dengan nomor: ${phoneController.text}',
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          PinVerificationPage(), 
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
