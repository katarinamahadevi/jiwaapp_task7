import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/controller/payment_summary_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';

Widget buildPaymentSummarySection(int orderId) {
  final orderController = Get.find<OrderController>();
  final paymentController = Get.find<PaymentSummaryController>();

  return Obx(() {
    if (paymentController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (paymentController.errorMessage.isNotEmpty) {
      return Text(
        paymentController.errorMessage.value,
        style: const TextStyle(color: Colors.red),
      );
    }

    final summary = paymentController.paymentSummary.value;

    if (summary == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Ringkasan Pembayaran',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap:
                      () =>
                          orderController.showPaymentSummaryModal(Get.context!),
                  child: const Icon(
                    Icons.info_outline,
                    color: BaseColors.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('Rp${summary.subtotalPrice}'),
              ],
            ),
            if (!orderController.isTakeAwaySelected) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ongkos Kirim'),
                  Text('Rp${summary.deliveryFee}'),
                ],
              ),
            ],
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp${summary.totalPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  });
}
