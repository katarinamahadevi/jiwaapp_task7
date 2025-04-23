import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiwaapp_task7/widgets/home_page/promo_banner.dart';

class PromoBanners extends StatelessWidget {
  const PromoBanners({Key? key}) : super(key: key);

  void _openWhatsApp() async {
    final url = Uri.parse("https://wa.me/628118891915");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
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
          onTap: _openWhatsApp,
        ),
        const SizedBox(height: 30),
        const PromoBanner(
          title: "Jiwa Care",
          description: "",
          imagePath: 'assets/image/image_jiwacare.png',
          fallbackColor: Color(0xFF321D59),
          fallbackText: "#TemanSejiwa\nAda Keluhan dan Saran?",
        ),
      ],
    );
  }
}
