import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiwaapp_task7/widgets/home_page/promo_banner.dart';

//BIG ORDER DAN JIWA CARE

class PromoBanners extends StatelessWidget {
  const PromoBanners({Key? key}) : super(key: key);

  void _openWhatsapp(BuildContext context) async {
    final Uri instagramAppUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );
    final Uri instagramWebUri = Uri.parse(
      'https://api.whatsapp.com/send/?phone=628118891915&text&type=phone_number&app_absent=0',
    );

    try {
      bool launched = await launchUrl(
        instagramAppUri,
        mode: LaunchMode.externalNonBrowserApplication,
      );

      // Jika gagal, buka di browser
      if (!launched) {
        launched = await launchUrl(
          instagramWebUri,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PromoBanner(
          title: "Big Order",
          description:
              "Mau pesen banyak dan dapat discount? Minimal pembelian 100 cup kamu bisa dapetin discount menarik loh, Yuk pesan sekarang!",
          imagePath: 'assets/image/image_big_order.png',
          fallbackColor: const Color(0xFF8E1F6D),
          fallbackText: "BIG ORDER\nDiskon 15%",
          onTap: () => _openWhatsapp(context), // Pass context here
        ),
        const SizedBox(height: 30),
        PromoBanner(
          title: "Jiwa Care",
          description: "",
          imagePath: 'assets/image/image_jiwacare.png',
          fallbackColor: Color(0xFF321D59),
          fallbackText: "#TemanSejiwa\nAda Keluhan dan Saran?",
          onTap: () => _openWhatsapp(context),
        ),
      ],
    );
  }
}
