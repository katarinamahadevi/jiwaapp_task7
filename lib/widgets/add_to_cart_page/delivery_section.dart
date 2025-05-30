import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';

Widget buildDeliverySection() {
  final OrderController orderController = Get.put(OrderController());
  final AddressController addressController = Get.put(AddressController());

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        final selectedAddress = addressController.selectedAddress;
        final selectedCourier = orderController.selectedCourier;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alamat Delivery',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () => orderController.navigateToDeliveryPage(),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Ubah Alamat',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (addressController.isLoading.value)
              const Center(child: CircularProgressIndicator())
            else if (addressController.hasError.value)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Error: ${addressController.errorMessage.value}',
                        style: TextStyle(color: Colors.red.shade600),
                      ),
                    ),
                  ],
                ),
              )
            else if (selectedAddress != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAddress.address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${selectedAddress.recipientName} - ${selectedAddress.phoneNumber}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedAddress.address,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_off, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Belum ada alamat yang dipilih',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BaseColors.greyBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catatan Alamat',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.article, color: Colors.grey, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedAddress?.note ?? '-',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pilih Kurir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => orderController.showCourierOptionModal(Get.context!),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB5D4BA),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child:
                            orderController.isLoadingCouriers
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : selectedCourier != null
                                ? _getCourierIcon(selectedCourier.name)
                                : const Icon(
                                  Icons.local_shipping,
                                  color: Colors.white,
                                  size: 20,
                                ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderController.isLoadingCouriers
                                ? 'Memuat kurir...'
                                : selectedCourier?.name ?? 'Pilih Kurir',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (selectedCourier != null &&
                              selectedCourier.code.isNotEmpty)
                            Text(
                              selectedCourier.code,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      orderController.isLoadingCouriers
                          ? '-'
                          : orderController.deliveryFeeFormatted,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ),
  );
}

Widget _getCourierIcon(String courierName) {
  String assetPath;

  if (courierName.toLowerCase().contains('grab')) {
    assetPath = 'assets/image/image_grab_express.png';
  } else if (courierName.toLowerCase().contains('gosend') ||
      courierName.toLowerCase().contains('gojek')) {
    assetPath = 'assets/logo/logo_gosend.jpeg';
  } else {
    assetPath = 'assets/image/image_delete.png';
  }

  return Image.asset(
    assetPath,
    width: 30,
    height: 30,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.local_shipping, color: Colors.white, size: 20);
    },
  );
}
