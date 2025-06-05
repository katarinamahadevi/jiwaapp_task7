import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/category_model.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/order_page/order_page.dart';
import 'package:jiwaapp_task7/pages/profile_page/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/menu_page/category_list_item.dart';
import 'package:jiwaapp_task7/widgets/menu_page/delivery_address_Bar.dart';
import 'package:jiwaapp_task7/widgets/menu_page/menu_item_card.dart';
import 'package:jiwaapp_task7/widgets/menu_page/outlet_selection_bar.dart';
import 'package:jiwaapp_task7/widgets/menu_page/search_bar.dart';
import 'package:jiwaapp_task7/widgets/menu_page/sliver_searchbar_delegate.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';
import 'package:jiwaapp_task7/widgets/menu_page/stack_view_order.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';
import 'package:jiwaapp_task7/controller/cart_controller.dart';

class MenuPage extends StatelessWidget {
  final bool showStackViewOrder;
  final double totalPrice;
  final int itemCount;

  MenuPage({
    Key? key,
    this.showStackViewOrder = false,
    this.totalPrice = 0.0,
    this.itemCount = 0,
  }) : super(key: key);

  final MenuItemController menuController = Get.put(MenuItemController());
  final CartController cartController = Get.put(CartController());
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _menuScrollController = ScrollController();

  void _onItemTapped(int index, BuildContext context) {
    if (index == 1) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavBar(
            selectedIndex: 1,
            onItemTapped: (index) => _onItemTapped(index, context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            color: BaseColors.primary,
          ),
          SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  _buildDeliveryTypeToggle(innerBoxIsScrolled),
                  buildDeliveryAddressBar(innerBoxIsScrolled),
                  buildOutletSelectionBar(innerBoxIsScrolled),
                  SliverPersistentHeader(
                    delegate: SliverSearchBarDelegate(
                      minHeight: 70.0,
                      maxHeight: 70.0,
                      child: buildSearchBar(),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: _buildMenuContent(),
            ),
          ),
          Obx(
            () =>
                cartController.totalCartItems.value > 0
                    ? Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: StackViewOrder(),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildDeliveryTypeToggle(bool innerBoxIsScrolled) {
    return SliverAppBar(
      backgroundColor: BaseColors.white,
      elevation: 0.0,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      title: Obx(
        () => Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5)),
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(50),
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
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                alignment:
                    menuController.isTakeAwaySelected.value
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: Container(
                  width: Get.width / 2 - 32,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: BaseColors.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => menuController.toggleDeliveryType(true),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Take Away',
                              style: TextStyle(
                                color:
                                    menuController.isTakeAwaySelected.value
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.directions_walk,
                              color:
                                  menuController.isTakeAwaySelected.value
                                      ? Colors.white
                                      : const Color(0xFF3B1D52),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => menuController.toggleDeliveryType(false),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                color:
                                    !menuController.isTakeAwaySelected.value
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.delivery_dining,
                              color:
                                  !menuController.isTakeAwaySelected.value
                                      ? Colors.white
                                      : const Color(0xFF3B1D52),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuContent() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Container(
            color: Colors.grey[100],
            child: Obx(
              () => ListView.builder(
                controller: _categoryScrollController,
                padding: EdgeInsets.zero,
                itemCount: menuController.categories.value.length,
                itemBuilder: (context, index) {
                  CategoryModel category =
                      menuController.categories.value[index];
                  bool isNew = index < 3;

                  return CategoryListItem(
                    category: category,
                    isNew: isNew,
                    isSelected:
                        index == menuController.selectedCategoryIndex.value,
                    onTap: () => menuController.selectCategory(index),
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (menuController.categories.value.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    menuController.selectedCategory!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child:
                      menuController.selectedCategoryProducts.isEmpty
                          ? const Center(
                            child: Text(
                              "No items available in this category",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          )
                          : GridView.builder(
                            controller: _menuScrollController,
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount:
                                menuController.selectedCategoryProducts.length,
                            itemBuilder: (context, index) {
                              return MenuItemCard(
                                menuItem:
                                    menuController
                                        .selectedCategoryProducts[index],
                                // Pass whether there are items in cart for StackViewOrder visibility
                                showStackViewOrder:
                                    cartController.totalCartItems.value > 0,
                                onAddToCart:
                                    () => menuController.addItemToCart(
                                      double.parse(
                                            menuController
                                                .selectedCategoryProducts[index]
                                                .price
                                                .replaceAll('Rp', '')
                                                .replaceAll('.', ''),
                                          ) /
                                          1000,
                                    ),
                                categoryType:
                                    menuController.selectedCategory?.type,
                              );
                            },
                          ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
