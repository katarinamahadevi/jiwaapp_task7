import 'package:flutter/material.dart';

class PromoEmptyState extends StatelessWidget {
  const PromoEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Image.asset(
            'assets/image/image_notifikasi_promo.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 12),
          const Text(
            'Belum ada informasi promo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Informasi promo kamu nanti bisa lihat disini ya!',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}