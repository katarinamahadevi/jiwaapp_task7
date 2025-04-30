import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/delivery_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/loyalty_membership_page.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';
import 'package:jiwaapp_task7/pages/my_voucher_page.dart';
import 'package:jiwaapp_task7/pages/onboarding_page.dart';
import 'package:jiwaapp_task7/pages/order_page.dart';
import 'package:jiwaapp_task7/pages/referral_page.dart';
import 'package:jiwaapp_task7/pages/subscription_page.dart';
import 'package:jiwaapp_task7/pages/update_profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_privacy_license.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

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

      // Jika gagal, buka di browser
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
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/logo/logo_jiwaplus.png',
                    height: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(),
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF2D1143),
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Mahadevi Katarina',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D1143),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '6287853591966',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mode_edit_outline,
                              color: Color(0xFF2D1143),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: BaseColors.purplepastel,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'MK5US6',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: Image.asset(
                                    'assets/image/image_referral_profile.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF46234C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: const Center(
                          child: Text(
                            'Undang teman dan dapatkan Voucher 50%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            imageAssetPath:
                                'assets/image/image_subscription.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const SubscriptionPage(),
                                ),
                              );
                            },
                            title: 'Subscription',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath:
                                'assets/image/image_order_history.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderPage(),
                                ),
                              );
                            },
                            title: 'Riwayat Pesanan',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath:
                                'assets/image/image_address_save.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeliveryPage(),
                                ),
                              );
                            },
                            title: 'Alamat Tersimpan',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath: 'assets/image/image_voucher.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyVoucherPage(),
                                ),
                              );
                            },
                            title: 'Voucher',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath:
                                'assets/image/image_loyalty_membership.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoyaltyMembershipPage(),
                                ),
                              );
                            },
                            title: 'Loyalty Membership',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath: 'assets/image/image_referral.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReferralPage(),
                                ),
                              );
                            },
                            title: 'Referral',
                            iconColor: BaseColors.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            imageAssetPath:
                                'assets/image/image_jiwacare_profile.png',
                            onTap: () => _openJiwaCare(context),

                            title: 'Jiwa Care',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath: 'assets/image/image_privacy.png',
                            onTap: () {},

                            title: 'Kebijakan Privasi',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            imageAssetPath: 'assets/image/image_logout.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnboardingPage(),
                                ),
                              );
                            },
                            title: 'Keluar',
                            iconColor: BaseColors.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Versi Aplikasi 3.8.4 (10047)',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Divider(
                          height: 1,
                          thickness: 2,
                          color: Color(0xFFEBEAEA),
                        ),
                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Informasi Kontak Layanan Pengaduan Konsumen Direktorat Jenderal Perlindungan Konsumen dan Tertib Niaga, Kementerian Perdagangan Republik Indonesia',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Whatsapp Ditjen PKTN : 0853-1111-1010',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String imageAssetPath,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(imageAssetPath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16, height: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 72.0, right: 40.0),
      child: const Divider(height: 1, thickness: 1, color: Color(0xFFB1B5B6)),
    );
  }
}
