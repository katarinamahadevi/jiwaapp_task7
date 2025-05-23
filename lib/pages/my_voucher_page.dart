import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/detail_voucher_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';

class MyVoucherPage extends StatefulWidget {
  const MyVoucherPage({Key? key}) : super(key: key);

  @override
  State<MyVoucherPage> createState() => _MyVoucherPageState();
}

class _MyVoucherPageState extends State<MyVoucherPage> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<Color> _borderColor = ValueNotifier<Color>(
    Colors.grey.shade300,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _borderColor.value =
          _controller.text.isNotEmpty ? Colors.red : Colors.grey.shade300;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _borderColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Diskon Spesial'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<Color>(
              valueListenable: _borderColor,
              builder: (context, borderColor, child) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Masukan Kode Promo',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Gunakan',
                            style: TextStyle(
                              color: BaseColors.primary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DELIVERY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailVoucherPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF8F8F8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: Image.asset(
                                'assets/banner/banner_diskon_ongkir.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 120,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Diskon Ongkir 20%',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: BaseColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          minimumSize: Size.zero,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.confirmation_num,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '10x',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Diskon Ongkir 20% hingga Rp. 12rb.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    'Tidak berlaku untuk menu Promo dan Flashsale.',
                                    style: TextStyle(fontSize: 14),
                                  ),

                                  const SizedBox(height: 16),

                                  Row(
                                    children: [
                                      _buildCategoryIcon(
                                        'assets/image/image_delivery_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_wallet_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_outlet.png',
                                        'ALL',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Expire pada 30 Apr 2025',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'INVOICE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailVoucherPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF8F8F8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: Image.asset(
                                'assets/banner/banner_diskon_invoice.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 120,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Diskon 15%',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: BaseColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          minimumSize: Size.zero,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.confirmation_num,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '4x',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Min. pembelian 35ribu, Maks. Diskon 15ribu.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    'Tidak berlaku untuk menu Promo dan Flashsale.',
                                    style: TextStyle(fontSize: 14),
                                  ),

                                  const SizedBox(height: 16),

                                  Row(
                                    children: [
                                      _buildCategoryIcon(
                                        'assets/image/image_delivery_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_wallet_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_outlet.png',
                                        'ALL',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Expire pada 30 Apr 2025',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailVoucherPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF8F8F8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: Image.asset(
                                'assets/banner/banner_diskon_invoice2.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 120,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Diskon 20%',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: BaseColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          minimumSize: Size.zero,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.confirmation_num,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '4x',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Min. pembelian 70ribu, Maks. Diskon 20ribu.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Text(
                                    'Tidak berlaku untuk menu Promo dan Flashsale.',
                                    style: TextStyle(fontSize: 14),
                                  ),

                                  const SizedBox(height: 16),

                                  Row(
                                    children: [
                                      _buildCategoryIcon(
                                        'assets/image/image_delivery_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_wallet_white.png',
                                        'ALL',
                                      ),
                                      const SizedBox(width: 50),
                                      _buildCategoryIcon(
                                        'assets/image/image_outlet.png',
                                        'ALL',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    'Expire pada 30 Apr 2025',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String imageAsset, String label) {
    return Row(
      children: [
        Image.asset(imageAsset, width: 24, height: 24, fit: BoxFit.contain),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
