 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/pages/outlet_options_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//PILIH OUTLET

SliverAppBar buildOutletSelectionBar(bool innerBoxIsScrolled) {
    final MenuItemController menuController = Get.put(MenuItemController());

    return SliverAppBar(
      backgroundColor: BaseColors.white,
      elevation: 0.0,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      title: Obx(
        () => GestureDetector(
          onTap: () {
            Get.to(() => OutletOptionsPage());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E5E5)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow:
                  innerBoxIsScrolled
                      ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ]
                      : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/image/image_outlet.png',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      !menuController.isTakeAwaySelected.value
                          ? 'RUKO RUNGKUT'
                          : 'KANNA HOMESTAY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Ubah',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }