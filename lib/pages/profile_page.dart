import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';
import 'package:jiwaapp_task7/pages/order_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';

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
              Padding(
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
                            Icons.edit,
                            color: Color(0xFF2D1143),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF46234C),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Center(
                        child: Text(
                          'Undang teman dan dapatkan Voucher 50%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF88688F),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
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
                          Icon(Icons.copy, color: Colors.white),
                          Spacer(),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icons.card_membership,
                            title: 'Subscription',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.receipt_long,
                            title: 'Riwayat Pesanan',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.location_on,
                            title: 'Alamat Tersimpan',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.confirmation_number,
                            title: 'Voucher',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.volunteer_activism,
                            title: 'Loyalty Membership',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.people,
                            title: 'Referral',
                            iconColor: BaseColors.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icons.support_agent,
                            title: 'Jiwa Care',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.shield,
                            title: 'Kebijakan Privasi',
                            iconColor: BaseColors.primary,
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.power_settings_new,
                            title: 'Keluar',
                            iconColor: BaseColors.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      'Versi Aplikasi 3.8.4 (10047)',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Divider(height: 1, thickness: 2, color: Color(0xFFEBEAEA)),
                    const SizedBox(height: 20),
                    Text(
                      'Informasi Kontak Layanan Pengaduan Konsumen Direktorat Jenderal Perlindungan Konsumen dan Tertib Niaga, Kementerian Perdagangan Republik Indonesia',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      'Whatsapp Ditjen PKTN : 0853-1111-1010',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    const SizedBox(height: 60),
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
    required IconData icon,
    required String title,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16, height: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black),
        ],
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
