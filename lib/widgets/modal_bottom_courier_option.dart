import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/model/courier_model.dart';
import 'package:jiwaapp_task7/theme/color.dart';

void showModalBottomCourierOption(BuildContext context) {
  final orderController = Get.find<OrderController>();

  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            return Padding(
              padding: const EdgeInsets.all(20),
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
                      'Pilih Kurir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: BaseColors.border),
                  const SizedBox(height: 10),

                  // Cek apakah data kurir kosong
                  if (orderController.couriers.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Memuat data kurir...'),
                        ],
                      ),
                    )
                  else
                    // List kurir dari controller
                    ...orderController.couriers.map((courier) {
                      final isSelected =
                          orderController.selectedCourier?.code == courier.code;

                      // Menentukan gambar berdasarkan nama kurir
                      String assetImage;
                      if (courier.name.toLowerCase().contains('grab')) {
                        assetImage = 'assets/image/image_grab_express.png';
                      } else if (courier.name.toLowerCase().contains(
                            'gosend',
                          ) ||
                          courier.name.toLowerCase().contains('gojek')) {
                        assetImage = 'assets/logo/logo_gosend.jpeg';
                      } else {
                        assetImage =
                            'assets/image/image_delete.png'; // fallback
                      }

                      return InkWell(
                        onTap: () {
                          orderController.selectCourier(courier);
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  assetImage,
                                  width: 30,
                                  height: 30,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.local_shipping,
                                      size: 20,
                                      color: Colors.grey[600],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courier.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  if (courier.code.isNotEmpty)
                                    Text(
                                      courier.code,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              'Rp${courier.fee.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected
                                        ? BaseColors.primary
                                        : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Radio<CourierModel>(
                              value: courier,
                              groupValue: orderController.selectedCourier,
                              activeColor: BaseColors.primary,
                              onChanged: (value) {
                                if (value != null) {
                                  orderController.selectCourier(value);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                  const SizedBox(height: 30),
                  Divider(color: BaseColors.border),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          orderController.couriers.isEmpty
                              ? null
                              : () {
                                Navigator.pop(context);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            orderController.couriers.isEmpty
                                ? Colors.grey
                                : BaseColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        orderController.couriers.isEmpty
                            ? 'Memuat...'
                            : 'Konfirmasi',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          });
        },
      );
    },
  );
}
