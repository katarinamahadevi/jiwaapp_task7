import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/pages/menu_page/menu_page.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_filter_order.dart';
import 'package:jiwaapp_task7/widgets/navbar.dart';
import 'package:jiwaapp_task7/widgets/order_page/ongoing_order.dart';
import 'package:jiwaapp_task7/widgets/order_page/order_history.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;
  late OrderController orderController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (Get.isRegistered<OrderController>()) {
      orderController = Get.find<OrderController>();
    } else {
      orderController = Get.put(OrderController());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        Future.delayed(Duration(milliseconds: 100), () {
          _refreshData();
        });
      }
    });
  }

  void _refreshData() {
    print('=== REFRESHING ORDER DATA ===');
    print('Current Tab: ${_tabController.index}');

    if (_tabController.index == 0) {
      orderController.fetchOngoingOrders(refresh: true);
    } else {
      orderController.fetchOrderHistory(refresh: true);
    }
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
          MaterialPageRoute(builder: (context) => MenuPage()),
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
            preferredSize: Size.fromHeight(145),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: _refreshData,
                            icon: const Icon(Icons.refresh),
                            tooltip: 'Refresh Orders',
                          ),
                        ],
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
                        onTap: (index) {
                          Future.delayed(Duration(milliseconds: 100), () {
                            _refreshData();
                          });
                        },
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: OngoingOrder(),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: OrderHistoryContent(),
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
