import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/delivery_page.dart';
import 'package:jiwaapp_task7/pages/detail_menucombo_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/order_page.dart';
import 'package:jiwaapp_task7/pages/outlet_options_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_view_cart.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';
import 'package:jiwaapp_task7/widgets/searchbar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentIndex = 1;
  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
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

  bool isTakeAwaySelected = true;
  int selectedCategoryIndex = 0;
  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _menuScrollController = ScrollController();

  final List<CategoryItem> categories = [
    CategoryItem(
      'Special For Mahadevi Katarina',
      isSelected: true,
      isNew: true,
    ),
    CategoryItem('Special Offers', isNew: true),
    CategoryItem('Nikmatnya Bersilaturahmi', isNew: true),
    CategoryItem('Combo Hemat'),
    CategoryItem('Kopi Signature'),
    CategoryItem('Kopi Kreasi Lokal'),
    CategoryItem('BURGER GEBER'),
    CategoryItem('SanGo'),
    CategoryItem('Jiwa Toast'),
    CategoryItem('Non-Coffee'),
  ];

  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Spesial Combo Jiwa Toast',
      price: 'Rp20.500',
      originalPrice: 'Rp37.000',
      imageUrl: 'assets/image/image_menu.png',
    ),
    MenuItem(
      title: 'Jiwa Toast Chicken Mayo',
      price: 'Rp22.000',
      originalPrice: 'Rp36.000',
      imageUrl: 'assets/image/menu_tunamayo.jpg',
    ),
    MenuItem(
      title: 'Paket Hemat Bertiga ',
      price: 'Rp15.000',
      originalPrice: 'Rp25.000',
      imageUrl: 'assets/image/menu_paketbertiga.png',
    ),
    MenuItem(
      title: 'Spesial Jajan Jiwa Toast',
      price: 'Rp18.000',
      originalPrice: 'Rp28.000',
      imageUrl: 'assets/image/menu_chickenmentai.jpg',
    ),
    MenuItem(
      title: 'Kopi Susu Latte Biscuit',
      price: 'Rp15.000',
      originalPrice: 'Rp25.000',
      imageUrl: 'assets/image/menu_latte.png',
    ),
    MenuItem(
      title: 'Kopi Susu Hazelnut',
      price: 'Rp15.000',
      originalPrice: 'Rp25.000',
      imageUrl: 'assets/image/image_menu.png',
    ),
    MenuItem(
      title: 'Susu Coklat Karamel',
      price: 'Rp15.000',
      originalPrice: 'Rp25.000',
      imageUrl: 'assets/image/menu_susucoklat.png',
    ),
    MenuItem(
      title: 'Paket Hemat Bertiga ',
      price: 'Rp15.000',
      originalPrice: 'Rp25.000',
      imageUrl: 'assets/image/menu_paketbertiga.png',
    ),
  ];

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _menuScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: _onItemTapped,
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
                  SliverAppBar(
                    backgroundColor: BaseColors.white,
                    elevation: 0.0,
                    floating: true,
                    pinned: false,
                    automaticallyImplyLeading: false,
                    title: Container(
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
                                    offset: Offset(0, 2),
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
                                isTakeAwaySelected
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 32,
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
                                  onTap: () {
                                    setState(() {
                                      isTakeAwaySelected = true;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Take Away',
                                          style: TextStyle(
                                            color:
                                                isTakeAwaySelected
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
                                              isTakeAwaySelected
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
                                  onTap: () {
                                    setState(() {
                                      isTakeAwaySelected = false;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                            color:
                                                !isTakeAwaySelected
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
                                              !isTakeAwaySelected
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
                  SliverAppBar(
                    backgroundColor: BaseColors.white,
                    elevation: 0.0,
                    floating: true,
                    pinned: false,
                    automaticallyImplyLeading: false,
                    toolbarHeight: !isTakeAwaySelected ? kToolbarHeight : 0,
                    title: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: !isTakeAwaySelected ? null : 0,
                      child: AnimatedOpacity(
                        opacity: !isTakeAwaySelected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryPage(),
                              ),
                            );
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
                                          offset: Offset(0, 2),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    backgroundColor: BaseColors.white,
                    elevation: 0.0,
                    floating: true,
                    pinned: false,
                    automaticallyImplyLeading: false,
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutletOptionsPage(),
                          ),
                        );
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
                                      offset: Offset(0, 2),
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
                                  !isTakeAwaySelected
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
                  SliverPersistentHeader(
                    delegate: _SliverSearchBarDelegate(
                      minHeight: 70.0,
                      maxHeight: 70.0,
                      child: Container(
                        color: BaseColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: CustomSearchBar(
                          hintText: 'Search menu',
                          icon: Icons.search,
                          backgroundColor: Colors.white,
                          borderColor: Colors.grey.shade200,
                          iconColor: BaseColors.secondary,
                          textColor: BaseColors.greyText,
                          onTap: () {
                            showModalBottomViewCart(context);
                          },
                        ),
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Row(
                children: [
                  // Category List with separate scroll
                  SizedBox(
                    width: 100,
                    child: Container(
                      color: Colors.grey[100],
                      child: ListView.builder(
                        controller: _categoryScrollController,
                        padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryListItem(
                            category: categories[index],
                            isSelected: index == selectedCategoryIndex,
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                                for (var i = 0; i < categories.length; i++) {
                                  categories[i].isSelected = i == index;
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  // Menu items with separate scroll
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            16.0,
                            16.0,
                            8.0, // Added bottom padding
                          ),
                          child: Text(
                            categories[selectedCategoryIndex].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            controller: _menuScrollController,
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      0.7, // Adjusted for more height
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount: menuItems.length,
                            itemBuilder: (context, index) {
                              return MenuItemCard(menuItem: menuItems[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverSearchBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CategoryItem {
  String name;
  bool isSelected;
  bool isNew;

  CategoryItem(this.name, {this.isSelected = false, this.isNew = false});
}

class CategoryListItem extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isSelected ? const Color(0xFFE56257) : Colors.transparent,
              width: 4.0,
            ),
          ),
          color: isSelected ? Colors.white : Colors.grey[100],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category.isNew)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B1D52),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              category.name,
              style: TextStyle(
                color: isSelected ? const Color(0xFFE56257) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              maxLines: 2, // Limit to 2 lines
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String price;
  final String originalPrice;
  final String imageUrl;

  MenuItem({
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
  });
}

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemCard({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final priceString = menuItem.price
            .replaceAll('Rp', '')
            .replaceAll('.', '');
        final price = double.parse(priceString) / 1000;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailMenucomboPage(
                  title: menuItem.title,
                  description:
                      'Perpaduan sempurna dari blend biji kopi pilihan, susu, manisnya karamel, dengan krim macchiato lembut di atasnya',
                  imageUrl: menuItem.imageUrl,
                  price: price,
                ),
          ),
        );
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
                      menuItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Slightly reduced font size
                      ),
                    ),
                    const Spacer(), // Use Spacer instead of SizedBox with fixed height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Use min size
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
                        Container(
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
            child: Image.asset(
              menuItem.imageUrl,
              height: 85,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
