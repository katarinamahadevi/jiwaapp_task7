import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';

Widget buildHeaderSection() {
  final OrderController controller = Get.put(OrderController());

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFE15B4C),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:
                      controller.isTakeAwaySelected
                          ? Image.asset(
                            'assets/image/image_take_away.png',
                            width: 28,
                            height: 28,
                          )
                          : Image.asset(
                            'assets/image/image_delivery.png',
                            width: 28,
                            height: 28,
                          ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.isTakeAwaySelected ? 'Take Away' : 'Delivery',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '0.55 km',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/image_outlet.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'KANNA HOMESTAY',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.navigateToOutletOptions(),
                  child: const Text(
                    'Ubah',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
