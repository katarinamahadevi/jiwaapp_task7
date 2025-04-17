import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/widgets/home_page/promo_banner.dart';

class PromoBanners extends StatelessWidget {
  const PromoBanners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        PromoBanner(
          title: "Big Order",
          description: "Mau pesen banyak dan dapat discount? Minimal pembelian 100 cup kamu bisa dapetin discount menarik loh, Yuk pesan sekarang!",
          imagePath: 'assets/banner/banner_promo1.jpg',
          fallbackColor: Color(0xFF8E1F6D),
          fallbackText: "BIG ORDER\nDiskon 15%",
        ),       
        SizedBox(height: 30),
        PromoBanner(
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