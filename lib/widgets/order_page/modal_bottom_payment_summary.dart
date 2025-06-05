import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

void showModalBottomPaymentSummary(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ringkasan Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: BaseColors.border),
              const SizedBox(height: 16),
              const Text(
                '1. Penggunaan voucher hanya akan mengurangi harga product non-bundling (promo)',
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Perhitungan diskon dihitung dari total nominal pembelian produk tanpa bundling.',
              ),
              const SizedBox(height: 10),
              const Text(
                '3. Perhitungan diskon delivery dihitung dari total nominal pembelian produk tanpa bundling setelah dikurangi diskon voucher lainnya.',
              ),
              const SizedBox(height: 10),
              const Text(
                '4. Maksimal nominal diskon delivery adalah sebesar delivery fee yang telah ditetapkan.',
              ),
              const SizedBox(height: 10),
              const Text(
                '5. Jiwa point hanya dapat digunakan maksimal 50% dari nilai Total Tagihan setelah dikurangi oleh voucher yang digunakan tanpa memperhitungkan tarif pengiriman kurir',
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }