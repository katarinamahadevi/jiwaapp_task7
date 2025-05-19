import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/category_model.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/delivery_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/order_page.dart';
import 'package:jiwaapp_task7/pages/outlet_options_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/menu_page/category_list_item.dart';
import 'package:jiwaapp_task7/widgets/menu_page/menu_item_card.dart';
import 'package:jiwaapp_task7/widgets/menu_page/sliver_searchbar_delegate.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';
import 'package:jiwaapp_task7/widgets/stack_view_order.dart';
import 'package:jiwaapp_task7/controller/menu_controller.dart';

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

  // Get the controller
  final MenuItemController menuController = Get.put(MenuItemController());
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _menuScrollController = ScrollController();

  void _onItemTapped(int index, BuildContext context) {
    if (index == 1) return; // Current page

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
    // Initialize controller values if coming from another page with items
    if (showStackViewOrder && menuController.totalPrice.value == 0) {
      menuController.totalPrice.value = totalPrice;
      menuController.itemCount.value = itemCount;
    }

    return Scaffold(
      backgroundColor: BaseColors.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavBar(
            selectedIndex: 1, // Menu page index
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
                  _buildDeliveryAddressBar(innerBoxIsScrolled),
                  _buildOutletSelectionBar(innerBoxIsScrolled),
                  SliverPersistentHeader(
                    delegate: SliverSearchBarDelegate(
                      minHeight: 70.0,
                      maxHeight: 70.0,
                      child: _buildSearchBar(),
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
                menuController.itemCount.value > 0 && showStackViewOrder
                    ? Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: StackViewOrder(
                        totalPrice: menuController.totalPrice.value,
                        itemCount: menuController.itemCount.value,
                      ),
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: BaseColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: CustomSearchBar(
        hintText: 'Search menu...',
        icon: Icons.search_sharp,
        iconColor: BaseColors.secondary,
        backgroundColor: Colors.white,
        textColor: Colors.grey,
        onChanged: (value) {
          print('Search input: $value');
        },
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

  SliverToBoxAdapter _buildDeliveryAddressBar(bool innerBoxIsScrolled) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (menuController.isTakeAwaySelected.value) {
          return const SizedBox.shrink(); 
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Get.to(() => DeliveryPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: BaseColors.border),
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
                        'assets/image/image_location_white.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Lokasi Delivery :',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Jilid 358 - RUKO RUNGKUT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  SliverAppBar _buildOutletSelectionBar(bool innerBoxIsScrolled) {
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
                  bool isNew = index < 3; // First 3 categories marked as new

                  return CategoryListItem(
                    category: category, // Passing the full CategoryModel object
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
                          ? Center(
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
