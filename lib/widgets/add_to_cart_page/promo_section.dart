import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/toggle_cupertino.dart';

Widget buildPromoSection() {
        final OrderController controller = Get.put(OrderController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: BaseColors.border),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFE15B4C),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/image/image_voucher.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              title: const Text(
                'Pakai Promo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => controller.navigateToVoucherPage(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Divider(
                height: 1,
                color: BaseColors.greyText,
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/image/image_jiwapoint_white.png',
                width: 36,
                height: 36,
              ),
              title: const Text(
                'Jiwa Point',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Saldo: 694'),
              trailing: ToggleCupertino(
                value: controller.jiwaPointActive,
                onChanged: (bool value) => controller.toggleJiwaPoint(value),
              ),
            ),
          ],
        ),
      ),
    );
  }