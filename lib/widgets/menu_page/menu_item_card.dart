import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/controller/cart_controller.dart';
import 'package:jiwaapp_task7/model/menu_model.dart';
import 'package:jiwaapp_task7/pages/menu_page/detail_menu_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_view_cart.dart';

//CARD MENU

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

    // Try to find CartController, if not found, put it
    CartController cartController;
    try {
      cartController = Get.find<CartController>();
    } catch (e) {
      cartController = Get.put(CartController());
    }

    return GestureDetector(
      onTap: () {
        print('=== MenuItemCard Tapped ===');
        print('Product ID: ${menuItem.id}');
        print('Product Name: ${menuItem.name}');

        // Check if product is already in cart using CartController
        bool isInCart = cartController.isProductInCart(menuItem.id);
        print('Product is in cart: $isInCart');

        if (isInCart) {
          // If product is in cart, show modal bottom view cart
          print('Showing modal because product is in cart');
          showModalBottomViewCart(context);
        } else {
          // If product is not in cart, navigate to detail page
          print('Navigating to detail page because product is not in cart');
          String? currentCategoryType =
              categoryType ?? controller.selectedCategory?.type;
          print('Category type: $currentCategoryType');

          Get.to(
            () => DetailMenuPage(
              menu: menuItem,
              categoryType: currentCategoryType,
            ),
          );
        }
        print('=== End MenuItemCard Tap ===');
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
                        // Show quantity badge if item is in cart, otherwise show add button
                        Obx(() {
                          bool isInCart = cartController.isProductInCart(
                            menuItem.id,
                          );
                          int quantity = cartController
                              .getProductQuantityInCart(menuItem.id);

                          print(
                            'Building UI for ${menuItem.name}: isInCart=$isInCart, quantity=$quantity',
                          );

                          if (isInCart && quantity > 0) {
                            return Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: BaseColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
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
                            );
                          }
                        }),
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
