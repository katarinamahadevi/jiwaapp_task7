import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/pages/menu_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Order Title
                      const Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: TabBar(
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Color(0xFFFD514F),
                              width: 3.0,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          labelColor: Color(0xFFFD514F),
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
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(child: EmptyOrderState()),
                HistoryOrderContent(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HistoryOrderContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          OrderHistoryCard(
            orderStatus: 'Order Completed',
            deliveryMethod: 'Delivery',
            deliveryIcon: Icons.delivery_dining,
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
            deliveryIcon: Icons.directions_walk,
            price: 'Rp65.000',
            orderId: 'J+202511417395185983261',
            dateTime: '14 Feb 2025 | 14:36',
            restaurant: 'BARATA',
            promo: 'Buy 1 Get 1 Free Minuman, Geber Beef Santuy',
            address: '',
            itemCount: '3 Item',
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final String orderStatus;
  final String deliveryMethod;
  final IconData deliveryIcon;
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
    required this.deliveryIcon,
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
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFE504F),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(deliveryIcon, color: Colors.white, size: 20),
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
          Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.2)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Order ID: ',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(orderId, style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.copy_outlined, size: 14),
                  ],
                ),
                Text(dateTime, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.store, size: 18),
                    ),
                    SizedBox(width: 8),
                    Text(
                      restaurant,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    itemCount,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          if (promo.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
              child: Text(
                promo,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          if (address.isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Color(0xFFFE504F),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.flag, color: Colors.white, size: 14),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFE504F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Pesan Ulang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFE504F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Detail Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
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
            decoration: BoxDecoration(
              color: Color(0xFFFD514F),
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 60,
                ),
                Positioned(
                  top: 30,
                  right: 22,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A148C),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
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
                MaterialPageRoute(builder: (context) => const MenuPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFD514F),
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
