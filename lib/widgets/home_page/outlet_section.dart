import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/outlet_options_page.dart';

//OPSI OUTLET

class OutletSection extends StatelessWidget {
  const OutletSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Buat Pesanan Sekarang",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OutletOptionsPage(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/image/image_outlet.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "BARATA",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _buildLogo(
                                'assets/logo/logo_janjijiwa.png',
                                'Janji Jiwa',
                              ),
                              const SizedBox(width: 12),
                              _buildLogo(
                                'assets/logo/logo_jiwatoast.png',
                                'JIWA',
                              ),
                              const SizedBox(width: 12),
                              _buildLogo(
                                'assets/logo/logo_burgergeber.png',
                                'Burger',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: const Text(
                      "Ubah",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String assetPath, String fallbackText) {
    return Image.asset(assetPath, width: 40, height: 25, fit: BoxFit.contain);
  }
}
