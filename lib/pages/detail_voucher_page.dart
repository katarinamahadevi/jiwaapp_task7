import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';

class DetailVoucherPage extends StatelessWidget {
  const DetailVoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Voucher Detail'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: BaseColors.blueContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: Color(0xFF036FB0)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Voucher hanya dapat digunakan pada halaman checkout',
                        style: TextStyle(
                          color: Color(0xFF036FB0),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/banner/banner_diskon_ongkir.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Diskon Ongkir 20%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Diskon Ongkir 20% hingga Rp. 12rb.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tidak berlaku untuk menu Promo dan Flashsale.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            DottedLine(
              dashLength: 6.0,
              dashGapLength: 4.0,
              lineThickness: 1.0,
              dashColor: BaseColors.border,
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Berlaku Sampai',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '30 Apr 2025',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Divider(color: BaseColors.border),
            ListTile(
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.article_outlined,
                  color: Colors.green,
                  size: 18,
                ),
              ),
              title: const Text(
                'Syarat dan Ketentuan',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Klik untuk melihat syarat dan ketentuan',
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(color: BaseColors.border),
            ListTile(
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
              title: const Text(
                'Cara Pakai Voucher',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Klik untuk melihat pembelanjaan voucher',
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(color: BaseColors.border),

            ListTile(
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  color: Colors.purple,
                  size: 18,
                ),
              ),
              title: const Text(
                'Partisipasi Outlet',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Klik untuk melihat partisipasi outlet',
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Pakai Voucher',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
