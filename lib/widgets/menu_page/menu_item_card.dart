import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/model/menu_model.dart';
import 'package:jiwaapp_task7/pages/menu_page/detail_menu_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_view_cart.dart';

class MenuItemCard extends StatelessWidget {
  final MenuModel menuItem;
  final bool showStackViewOrder;
  final Function() onAddToCart;
  final String? categoryType;

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    this.showStackViewOrder = false,
    required this.onAddToCart,
    this.categoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuItemController controller = Get.find<MenuItemController>();

    return GestureDetector(
      onTap: () {
        if (showStackViewOrder) {
          showModalBottomViewCart(context);
        } else {
          // Get the current category type from controller
          String? currentCategoryType =
              categoryType ?? controller.selectedCategory?.type;

          // Navigate to detail page with category type
          Get.to(
            () => DetailMenuPage(
              menu: menuItem,
              categoryType: currentCategoryType,
            ),
          );
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 55, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      menuItem.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              menuItem.price,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              menuItem.originalPrice,
                              style: const TextStyle(
                                fontSize: 12,
                                color: BaseColors.primary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Prevent navigation when add button is tapped
                            onAddToCart();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: BaseColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              menuItem.imageUrlText,
              height: 85,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
