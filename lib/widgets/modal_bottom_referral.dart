import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//MODAL BOTTOM TATA CARA REFERRAL

void showModalBottomReferral(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cara menggunakan kode referral',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFFF1F1F1),
                        child: Icon(Icons.close, color: Colors.black, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildStep(
                  number: '1',
                  title: 'Ajak temanmu menggunakan JIWA+',
                  description:
                      'Bagikan link referral kamu lewat media sosial atau Whatsapp',
                ),
                const SizedBox(height: 16),
                _buildStep(
                  number: '2',
                  title: 'Pastikan temanmu mendaftar dengan kode kamu',
                  description:
                      'klik link referral untuk dapatkan voucher Diskon 50% setelah transaksi pertamanya',
                ),
                const SizedBox(height: 16),
                _buildStep(
                  number: '3',
                  title: 'Dapatkan Diskon 50%!',
                  description:
                      'Tingkatkan level loyalty membership kamu untuk mendapatkan lebih banyak reward',
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildStep({
  required String number,
  required String title,
  required String description,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 12),
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: BaseColors.primary,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    ],
  );
}
