import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/order_controller.dart';
import 'package:jiwaapp_task7/model/order_model.dart';
import 'package:jiwaapp_task7/pages/order_status_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class OngoingOrder extends StatefulWidget {
  @override
  State<OngoingOrder> createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  late ScrollController _scrollController;
  late OrderController controller;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Get the controller instance
    if (Get.isRegistered<OrderController>()) {
      controller = Get.find<OrderController>();
    } else {
      controller = Get.put(OrderController());
    }

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (controller.hasMoreData && !controller.isLoadingOrders) {
        print('Loading more ongoing orders...');
        controller.fetchOngoingOrders(refresh: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: controller,
      builder: (controller) {
        return Obx(() {
          if (controller.isLoadingOrders && controller.ongoingOrders.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (controller.ongoingOrders.isEmpty && !controller.isLoadingOrders) {
            return RefreshIndicator(
              onRefresh: () => controller.fetchOngoingOrders(refresh: true),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No ongoing orders',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchOngoingOrders(refresh: true),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // Space for bottom nav
              itemCount:
                  controller.ongoingOrders.length +
                  (controller.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.ongoingOrders.length) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child:
                        controller.isLoadingOrders
                            ? const CircularProgressIndicator()
                            : const SizedBox.shrink(),
                  );
                }

                final OrderModel order = controller.ongoingOrders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: OngoingOrderCard(order: order, controller: controller),
                );
              },
            ),
          );
        });
      },
    );
  }
}

class OngoingOrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderController controller;

  const OngoingOrderCard({
    Key? key,
    required this.order,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDE1E4)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF46234C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              order.orderStatus == 'Pending Payment'
                  ? 'Lakukan Pembayaran'
                  : order.orderStatus,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          controller.getDeliveryIconAsset(order.orderType),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      order.orderType,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  _formatOrderPrice(order.subtotalPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Order ID: ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          order.orderCode ?? 'N/A',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => _copyOrderCode(order.orderCode),
                        child: const Icon(Icons.copy, size: 14),
                      ),
                    ],
                  ),
                ),
                Text(
                  controller.formatDateTime(order.createdAt),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.itemCount} Item${order.itemCount > 1 ? 's' : ''}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          if (order.orderType.toLowerCase() == 'delivery' &&
              order.addressId != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.flag, size: 14, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Alamat pengiriman tersedia',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToOrderStatus(context, order.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                  ),
                  child: Text(
                    order.orderStatus == 'Pending Payment' ? 'Bayar' : 'Status',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToOrderStatus(context, order.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  child: const Text(
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

  String _formatOrderPrice(int price) {
    return 'Rp${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _copyOrderCode(String? orderCode) {
    if (orderCode != null) {
      // Implement copy to clipboard functionality
      Get.snackbar(
        'Copied',
        'Order code copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _navigateToOrderStatus(BuildContext context, int orderId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderStatusPage(),
        settings: RouteSettings(arguments: {'orderId': orderId}),
      ),
    );
  }
}
