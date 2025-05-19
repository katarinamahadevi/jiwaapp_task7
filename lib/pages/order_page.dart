import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/order_detail_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_filter_order.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_order_repeat.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          MaterialPageRoute(builder: (context) =>  MenuPage()),
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
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(110),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: const Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(color: Colors.white),
                      child: TabBar(
                        controller: _tabController,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: BaseColors.primary,
                            width: 3.0,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 0),
                        ),
                        labelColor: BaseColors.primary,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: const [
                          Tab(text: 'Ongoing'),
                          Tab(text: 'History'),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: EmptyOrderState(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: HistoryOrderContent(),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _currentIndex,
            onItemTapped: _onItemTapped,
          ),
        ),

        Positioned(
          bottom: 80,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomFilterOrder(context);
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: BaseColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: BaseColors.primary,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Filter',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryOrderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Delivery',
          deliveryIconAsset: 'assets/image/image_take_away.png',
          price: 'Rp41.500',
          orderId: 'J+202512617405493000001',
          dateTime: '26 Feb 2025 | 12:55',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman',
          address:
              'Ordo apps - Taman Jemursari Selatan 1, Jemur Wonosari, Surabaya, Ja...',
          itemCount: '1 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 16),
        OrderHistoryCard(
          orderStatus: 'Order Completed',
          deliveryMethod: 'Take Away',
          deliveryIconAsset: 'assets/image/image_delivery.png',
          price: 'Rp65.000',
          orderId: 'J+202511417395185983261',
          dateTime: '14 Feb 2025 | 14:36',
          restaurant: 'BARATA',
          promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
          address: '',
          itemCount: '3 Item',
        ),
        SizedBox(height: 80),
      ],
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final String orderStatus;
  final String deliveryMethod;
  final String deliveryIconAsset;
  final String price;
  final String orderId;
  final String dateTime;
  final String restaurant;
  final String promo;
  final String address;
  final String itemCount;

  const OrderHistoryCard({
    required this.orderStatus,
    required this.deliveryMethod,
    required this.deliveryIconAsset,
    required this.price,
    required this.orderId,
    required this.dateTime,
    required this.restaurant,
    required this.promo,
    required this.address,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFDDE1E4)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFF46234C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              orderStatus,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE65952),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          deliveryIconAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      deliveryMethod,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),

          Divider(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Order ID: ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          orderId,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.copy, size: 14),
                    ],
                  ),
                ),
                Text(dateTime, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Image.asset(
                          'assets/image/image_outlet.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          restaurant,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  itemCount,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          if (promo.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                promo,
                style: TextStyle(color: Colors.grey, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),

          if (address.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: BaseColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.flag, size: 14, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomOrderRepeat(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ), // padding internal
                  ),
                  child: Text(
                    'Pesan Ulang',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ), // padding internal
                  ),
                  child: Text(
                    'Detail Pesanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyOrderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE65952),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/image/image_order.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            'Belum ada pesanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            'Kamu bisa cek pesanan yang sedang diproses di sini',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  MenuPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: BaseColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Pesan Sekarang',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
