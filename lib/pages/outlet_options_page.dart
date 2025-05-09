import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/outlet_detail_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

class OutletOptionsPage extends StatefulWidget {
  const OutletOptionsPage({Key? key}) : super(key: key);

  @override
  State<OutletOptionsPage> createState() => _OutletOptionsPageState();
}

class _OutletOptionsPageState extends State<OutletOptionsPage> {
  bool isOperatingSelected = true;
  String selectedFilter = "Semua";
  String selectedBrand = "Semua Brand";
  String? selectedOutletId;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Pilih Outlet'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomSearchBar(
              hintText: 'Cari outlet yang kamu mau disini',
              icon: Icons.store_mall_directory_outlined,
              iconColor: BaseColors.primary,
              backgroundColor: Colors.white,
              textColor: Colors.grey,
              onChanged: (value) {
                print('Search input: $value');
              },
            ),

            // CustomSearchBar(
            //   hintText: 'Cari outlet yang kamu mau di sini',
            //   icon: Icons.store_mall_directory_outlined,
            //   iconColor: BaseColors.primary,
            //   backgroundColor: Colors.white,
            //   textColor: Colors.grey,
            //   onChanged: (value) {
            //     print('Search input: $value');
            //   },
            // ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOperatingSelected = true;
                      });
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            isOperatingSelected
                                ? BaseColors.primary
                                : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            isOperatingSelected
                                ? null
                                : Border.all(color: Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Sedang Beroperasi",
                        style: TextStyle(
                          color:
                              isOperatingSelected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOperatingSelected = false;
                      });
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            !isOperatingSelected
                                ? BaseColors.primary
                                : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            !isOperatingSelected
                                ? null
                                : Border.all(color: Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Semua Outlet",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              !isOperatingSelected
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
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
                  _buildFilterChip("Semua", selectedFilter == "Semua"),
                  const SizedBox(width: 10),
                  _buildFilterChip("Dine In", selectedFilter == "Dine In"),
                  const SizedBox(width: 10),
                  _buildFilterChip("Take Away", selectedFilter == "Take Away"),
                  const SizedBox(width: 10),
                  _buildFilterChip("Delivery", selectedFilter == "Delivery"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBrandChip(
                    "Semua Brand",
                    selectedBrand == "Semua Brand",
                  ),
                  const SizedBox(width: 8),
                  ...allBrandLogos.map(
                    (logo) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: _buildBrandImage(logo, selectedBrand == logo),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: BaseColors.border),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
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
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedFilter == label) {
            selectedFilter = "Semua";
          } else {
            selectedFilter = label;
          }
        });
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildBrandChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrand = label;
        });
      },
      child: Container(
        height: 36,
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
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildBrandImage(String logoPath, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrand = logoPath;
        });
      },
      child: Container(
        height: 36,
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? BaseColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Image.asset(logoPath, height: 30, width: 30),
      ),
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
    final String outletId = "$name-$code";
    final bool isSelected = selectedOutletId == outletId;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOutletId = isSelected ? null : outletId;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: isSelected ? BaseColors.primary : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(20),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(color: BaseColors.greenContainer),
                  child: const Text(
                    "Buka",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
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
                            (context) =>
                                OutletDetailPage(outletData: outletData),
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
      ),
    );
  }
}
