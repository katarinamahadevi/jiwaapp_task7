import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/auth_page/login_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_privacy_license.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_verifyotp.dart';
import 'package:url_launcher/url_launcher.dart';

//HALAMAN ONBOARDING (MASUK KE LOGIN/REGISTER)

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  //FUNGSI MEMBUKA WA JIWACARE
  void _openJiwaCare(BuildContext context) async {
    final Uri JiwaCareAppUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );
    final Uri JiwaCareWebUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );

    try {
      bool launched = await launchUrl(
        JiwaCareAppUri,
        mode: LaunchMode.externalNonBrowserApplication,
      );

      if (!launched) {
        launched = await launchUrl(
          JiwaCareWebUri,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka Instagram')),
        );
      }
    } catch (e) {
      print('Error membuka Instagram: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/logo/logo_jiwaplus.png', height: 30),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: BaseColors.secondary,
                        size: 40,
                      ),

                      const SizedBox(width: 15),
                      const Text(
                        'Teman Sajiwa',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                    child:
                    //NAVIGASI KE LOGIN PAGE
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login disini',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFE75C55),
                          radius: 30,
                          child: Image.asset(
                            'assets/image/image_jiwacare_profile.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      title: const Text(
                        'Jiwa Care',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                      onTap: () => _openJiwaCare(context),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: BaseColors.greyText,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: BaseColors.primary,
                          radius: 30,
                          child: Image.asset(
                            'assets/image/image_privacy.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      title: const Text(
                        'Kebijakan Privasi',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                      onTap: () {
                        showModalBottomPrivacyLicense(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 40),
                child: Text(
                  'Versi Aplikasi 3.8.4 (10047)',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            const Spacer(),
            Divider(color: BaseColors.border, thickness: 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Kontak Layanan Pengaduan Konsumen Direktorat Jenderal Perlindungan Konsumen dan Tertib Niaga, Kementerian Perdagangan Republik Indonesia',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Whatsapp Ditjen PKTN : 0853-1111-1010',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
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
