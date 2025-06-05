import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:get/get.dart';

Future<void> showModalBottomCancelOrder(
  BuildContext context, {
  required int orderId,
  required VoidCallback onCancelSuccess,
  required Function(String, {bool isError}) showSnackbar,
  required Future<void> Function(int) cancelPaymentFunction,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (BuildContext context) {
      // State untuk loading
      final RxBool isLoading = false.obs;

      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: BaseColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE65952),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/image/image_order.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Batalkan pesanan ini?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pesanan yang dibatalkan tidak akan mendapat XP dan Jiwa Point. Kami akan mengembalikan voucher dan Jiwa Point yang digunakan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Obx(() => Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading.value 
                        ? null 
                        : () async {
                            try {
                              isLoading.value = true;
                              await cancelPaymentFunction(orderId);
                              onCancelSuccess();
                            } catch (e) {
                              showSnackbar(
                                'Gagal membatalkan pesanan: $e',
                                isError: true,
                              );
                            } finally {
                              isLoading.value = false;
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65952),
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Batalkan',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading.value 
                        ? null 
                        : () {
                            Navigator.of(context).pop();
                          },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      side: BorderSide(
                        color: isLoading.value ? Colors.grey : Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14, 
                        color: isLoading.value ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      );
    },
  );
}