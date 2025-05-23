import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

//HI MAHADEVI KATARINA DAN NOTIFIKASI

class Greetingbar extends StatelessWidget {
  final double imageHeight;
  final VoidCallback onNotificationTap;

  Greetingbar({
    Key? key,
    required this.imageHeight,
    required this.onNotificationTap,
  }) : super(key: key);

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final name = profileController.user.value?.name ?? '';

      return Positioned(
        top: imageHeight - 60,
        left: 20,
        right: 20,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hi, $name",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: onNotificationTap,
                  child: _buildNotificationBadge(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNotificationBadge() {
    return Stack(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFE05D56),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications, color: Colors.white, size: 16),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Text(
              "46",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
