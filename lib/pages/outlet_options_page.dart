import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/outlet_detail_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

class OutletOptionsPage extends StatelessWidget {
  const OutletOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allBrandLogos = [
      'assets/logo/logo_jiwaplus.png',
      'assets/logo/logo_janjijiwa.png',
      'assets/logo/logo_jiwatoast.png',
      'assets/logo/logo_burgergeber.png',
      'assets/logo/logo_jiwatea.png',
      'assets/logo/logo_sejutajiwa.png',
    ];

    final kannaLogos = [
      'assets/logo/logo_janjijiwa.png',
      'assets/logo/logo_jiwatea.png',
      'assets/logo/logo_burgergeber.png',
    ];

    final barataLogos = [
      'assets/logo/logo_janjijiwa.png',
      'assets/logo/logo_jiwatea.png',
      'assets/logo/logo_jiwatoast.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Pilih Outlet'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            CustomSearchBar(
              hintText: 'Cari outlet yang kamu mau di sini',
              icon: Icons.store_mall_directory_outlined,
              backgroundColor: Colors.white,
              borderColor: Colors.grey.shade200,
              iconColor: BaseColors.primary,
              textColor: Colors.grey,
              onTap: () {},
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: BaseColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Sedang Beroperasi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Semua Outlet",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip("Semua", true),
                  const SizedBox(width: 10),
                  _buildFilterChip("Dine In", false),
                  const SizedBox(width: 10),
                  _buildFilterChip("Take Away", false),
                  const SizedBox(width: 10),
                  _buildFilterChip("Delivery", false),
                ],
              ),
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBrandChip("Semua Brand", true),
                  const SizedBox(width: 8),
                  ...allBrandLogos.map(
                    (logo) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: _buildBrandImage(logo),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildOutletCard(
              context: context,
              name: 'KANNA HOMESTAY',
              code: 'Jilid 306',
              isOpen: true,
              time: '07:00 - 22:00 WIB',
              distance: 0.55,
              address:
                  'Jl. Kelampis Semolo Timur 41 Rt 001 Rw 009\nKelurahan Semolowaru Kecamatan Sukolilo Kode Pos 60119\nSurabaya',
              logos: kannaLogos, 
              bgColor: Colors.white,
              kmColor: BaseColors.greenContainer,
              outletData: {
                'name': 'KANNA HOMESTAY',
                'code': 'Jilid 306',
                'address':
                    'Jl. Kelampis Semolo Timur 41 Rt 001 Rw 009 Kelurahan Semolowaru Kecamatan Sukolilo Kode Pos 60119 Surabaya',
                'logos': kannaLogos,
              },
            ),

            const SizedBox(height: 16),

            _buildOutletCard(
              context: context,
              name: 'BARATA',
              code: 'Jilid 752',
              isOpen: true,
              time: '07:00 - 22:00 WIB',
              distance: 1.92,
              address: 'Jl. Barata Jaya 19 No 52B Surabaya',
              logos: barataLogos, 
              bgColor: Colors.white,
              kmColor: BaseColors.blueContainer,
              outletData: {
                'name': 'BARATA',
                'code': 'Jilid 00752',
                'address': 'Jl. Barata Jaya 19 No 52B Surabaya',
                'logos': barataLogos,
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? BaseColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? BaseColors.primary : Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBrandChip(String label, bool isSelected) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFE25C4B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? Color(0xFFE25C4B) : Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBrandImage(String logoPath) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(logoPath, height: 20),
    );
  }

  Widget _buildOutletCard({
    required BuildContext context,
    required String name,
    required String code,
    required bool isOpen,
    required String time,
    required double distance,
    required String address,
    required List<String> logos,
    required Color bgColor,
    required Color kmColor,
    required Map<String, dynamic> outletData,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                code,
                style: TextStyle(color: BaseColors.black, fontSize: 14),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: BaseColors.greenContainer),
                child: const Text(
                  "Buka",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: BaseColors.greenContainer),
                child: Text(
                  time,
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$distance km",
                style: TextStyle(color: BaseColors.black, fontSize: 14),
              ),
              Text(
                " - ",
                style: TextStyle(color: BaseColors.greyText, fontSize: 14),
              ),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    color: BaseColors.greyText,
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var logo in logos)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(logo, height: 24),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: BaseColors.primary,
                  child: Image.asset(
                    'assets/image/image_take_away.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                child: CircleAvatar(
                  backgroundColor: BaseColors.primary,
                  child: Image.asset(
                    'assets/image/image_delivery.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kmColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${distance.toStringAsFixed(2)} KM',
                  style: TextStyle(
                    fontSize: 12,
                    color: distance < 1.0 ? Colors.green : Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE25C4B),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OutletDetailPage(outletData: outletData),
                    ),
                  );
                },
                child: const Text(
                  'Detail Outlet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
