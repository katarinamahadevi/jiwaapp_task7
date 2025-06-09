import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/model/address_model.dart';
import 'package:jiwaapp_task7/model/courier_model.dart';
import 'package:jiwaapp_task7/model/order_model.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/delivery_page.dart';
import 'package:jiwaapp_task7/pages/menu_page/menu_page.dart';
import 'package:jiwaapp_task7/pages/order_page/order_status_page.dart';
import 'package:jiwaapp_task7/pages/order_page/payment_webview_page.dart';
import 'package:jiwaapp_task7/services/courier_service.dart';
import 'package:jiwaapp_task7/services/order_service.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';
import 'package:jiwaapp_task7/widgets/add_to_cart_page/modal_bottom_courier_option.dart';
import 'package:jiwaapp_task7/widgets/order_page/modal_bottom_payment_summary.dart';

class OrderController extends GetxController {
  final _isTakeAwaySelected = true.obs;
  final _couriers = <CourierModel>[].obs;
  final _selectedCourier = Rxn<CourierModel>();
  final _isLoadingCouriers = false.obs;
  final _isProcessingOrder = false.obs;
  final _selectedAddressId = 0.obs;
  final _selectedAddress = 0.obs;

  final _orderItems = <Map<String, dynamic>>[].obs;
  final _currentOrder = Rxn<OrderModel>();
  final _orderDetail = Rxn<OrderModel>();
  final _isLoadingOrderDetail = false.obs;

  final _ongoingOrders = <OrderModel>[].obs;
  final _orderHistory = <OrderModel>[].obs;

  final _isLoadingOngoingOrders = false.obs;
  final _isLoadingOrderHistory = false.obs;
  final _ongoingCurrentPage = 1.obs;
  final _historyCurrentPage = 1.obs;
  final _ongoingHasMoreData = true.obs;
  final _historyHasMoreData = true.obs;

  final CourierService _courierService = CourierService();
  final OrderService _orderService = OrderService();
  final CartService _cartService = CartService();

  bool get isLoadingCouriers => _isLoadingCouriers.value;
  bool get isProcessingOrder => _isProcessingOrder.value;

  bool get isLoadingOngoingOrders => _isLoadingOngoingOrders.value;
  bool get isLoadingOrderHistory => _isLoadingOrderHistory.value;

  bool get isLoadingOrders =>
      _isLoadingOngoingOrders.value || _isLoadingOrderHistory.value;

  List<CourierModel> get couriers => _couriers;
  CourierModel? get selectedCourier => _selectedCourier.value;
  bool get isTakeAwaySelected => _isTakeAwaySelected.value;
  int get selectedAddressId => _selectedAddressId.value;
  int get selectedAddress => _selectedAddress.value;

  List<Map<String, dynamic>> get orderItems => _orderItems;
  OrderModel? get currentOrder => _currentOrder.value;
  List<OrderModel> get ongoingOrders => _ongoingOrders;
  List<OrderModel> get orderHistory => _orderHistory;

  bool get ongoingHasMoreData => _ongoingHasMoreData.value;
  bool get historyHasMoreData => _historyHasMoreData.value;

  bool get hasMoreData => _historyHasMoreData.value;

  OrderModel? get orderDetail => _orderDetail.value;
  bool get isLoadingOrderDetail => _isLoadingOrderDetail.value;

  final RxInt currentOrderId = 0.obs;

  //MENGAMBIL DATA DETAIL ORDER BERDASARKAN ID
  Future<void> fetchOrderDetail(int orderId) async {
    try {
      _isLoadingOrderDetail.value = true;
      print('Fetching order detail for ID: $orderId');

      final order = await _orderService.getOrderById(orderId);
      _orderDetail.value = order;

      print('Order detail loaded successfully: ${order.orderCode}');
    } catch (e) {
      print('Error fetching order detail: $e');
      showSnackbar('Gagal memuat detail pesanan: $e', isError: true);
    } finally {
      _isLoadingOrderDetail.value = false;
    }
  }

  //MEMFILTER DATA ONGOING ORDER
  Future<void> fetchOngoingOrders({bool refresh = false}) async {
    if (refresh) {
      _ongoingCurrentPage.value = 1;
      _ongoingHasMoreData.value = true;
      _ongoingOrders.clear();
    }

    if (_isLoadingOngoingOrders.value || !_ongoingHasMoreData.value) return;

    try {
      _isLoadingOngoingOrders.value = true;
      print(
        'Fetching ongoing orders - Page: ${_ongoingCurrentPage.value}, Refresh: $refresh',
      );

      final response = await _orderService.getOrders(
        page: _ongoingCurrentPage.value,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['orders'];
        if (data != null && data['data'] != null) {
          List<dynamic> ordersData = data['data'];
          List<OrderModel> fetchedOrders =
              ordersData
                  .map((orderJson) => OrderModel.fromJson(orderJson))
                  .where((order) => _isOngoingOrder(order.orderStatus))
                  .toList();

          print(
            'Fetched ${fetchedOrders.length} ongoing orders from page ${_ongoingCurrentPage.value}',
          );

          if (refresh) {
            _ongoingOrders.assignAll(fetchedOrders);
          } else {
            _ongoingOrders.addAll(fetchedOrders);
          }

          _ongoingHasMoreData.value = data['next_page_url'] != null;
          if (_ongoingHasMoreData.value) {
            _ongoingCurrentPage.value++;
          }
        } else {
          _ongoingHasMoreData.value = false;
        }
      } else {
        _ongoingHasMoreData.value = false;
      }
    } catch (e) {
      print('Error fetching ongoing orders: $e');
      showSnackbar('Failed to load ongoing orders: $e', isError: true);
      _ongoingHasMoreData.value = false;
    } finally {
      _isLoadingOngoingOrders.value = false;
    }
  }

  //MEMFILTER DATA HISTORY ORDER
  Future<void> fetchOrderHistory({bool refresh = false}) async {
    if (refresh) {
      _historyCurrentPage.value = 1;
      _historyHasMoreData.value = true;
      _orderHistory.clear();
    }

    if (_isLoadingOrderHistory.value || !_historyHasMoreData.value) return;

    try {
      _isLoadingOrderHistory.value = true;
      print(
        'Fetching order history - Page: ${_historyCurrentPage.value}, Refresh: $refresh',
      );

      final response = await _orderService.getOrders(
        page: _historyCurrentPage.value,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['orders'];
        if (data != null && data['data'] != null) {
          List<dynamic> ordersData = data['data'];
          List<OrderModel> fetchedOrders =
              ordersData
                  .map((orderJson) => OrderModel.fromJson(orderJson))
                  .where((order) => _isCompletedOrder(order.orderStatus))
                  .toList();

          print(
            'Fetched ${fetchedOrders.length} history orders from page ${_historyCurrentPage.value}',
          );

          for (var order in fetchedOrders) {
            print(
              'History Order: ${order.orderCode} - Status: ${order.orderStatus}',
            );
          }

          if (refresh) {
            _orderHistory.assignAll(fetchedOrders);
          } else {
            _orderHistory.addAll(fetchedOrders);
          }

          _historyHasMoreData.value = data['next_page_url'] != null;
          if (_historyHasMoreData.value) {
            _historyCurrentPage.value++;
          }
        } else {
          _historyHasMoreData.value = false;
        }
      } else {
        _historyHasMoreData.value = false;
      }
    } catch (e) {
      print('Error fetching order history: $e');
      showSnackbar('Failed to load order history: $e', isError: true);
      _historyHasMoreData.value = false;
    } finally {
      _isLoadingOrderHistory.value = false;
    }
  }

  //FILTER STATUS ONGOING ORDER
  bool _isOngoingOrder(String status) {
    const ongoingStatuses = ['Pending', 'Processing'];
    return ongoingStatuses.contains(status);
  }

  //FILTER STATUS HISTORY ORDER
  bool _isCompletedOrder(String status) {
    const completedStatuses = ['Completed', 'Cancelled'];
    return completedStatuses.contains(status);
  }

  String formatPrice(int price) {
    return 'Rp${price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  //FORMAT DATE
  String formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      final day = dateTime.day.toString().padLeft(2, '0');
      final month = months[dateTime.month];
      final year = dateTime.year;
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$day $month $year | $hour:$minute';
    } catch (e) {
      return dateTimeString;
    }
  }

  //PERUBAHAN TYPE DELIVERY ASSET
  String getDeliveryIconAsset(String orderType) {
    return orderType.toLowerCase() == 'delivery'
        ? 'assets/image/image_take_away.png'
        : 'assets/image/image_delivery.png';
  }

  //BUAT NGEDETEKSI TYPE STATUS ORDER DI ADDTOCARTPAGE
  Future<void> toggleDeliveryOption(bool isTakeAway) async {
    try {
      _isTakeAwaySelected.value = isTakeAway;
      if (isTakeAway) {
        _selectedCourier.value = null;
      } else if (_couriers.isEmpty) {
        await loadCouriers();
      }

      if (_orderItems.isNotEmpty && _canCreateOrder()) {
        await _createOrUpdateOrder();
      }
    } catch (e) {
      print('Error toggling delivery option: $e');
      showSnackbar('Gagal mengubah opsi pengiriman: $e', isError: true);
    }
  }

  bool _canCreateOrder() {
    if (_isTakeAwaySelected.value) {
      return _orderItems.isNotEmpty;
    } else {
      return _orderItems.isNotEmpty &&
          _selectedAddressId.value > 0 &&
          _selectedCourier.value != null;
    }
  }

  Future<void> _createOrUpdateOrder() async {
    final orderType = _isTakeAwaySelected.value ? 'Take Away' : 'Delivery';
    final courier =
        _isTakeAwaySelected.value
            ? 'none'
            : (_selectedCourier.value?.name ?? 'none');
    final deliveryFee =
        _isTakeAwaySelected.value
            ? 0.0
            : (_selectedCourier.value?.fee.toDouble() ?? 0.0);
    final addressId = _isTakeAwaySelected.value ? 0 : _selectedAddressId.value;

    print(
      'Creating order with type: $orderType, addressId: $addressId, courier: $courier, deliveryFee: $deliveryFee',
    );

    final order = await _orderService.createOrder(
      addressId: addressId,
      orderType: orderType,
      courier: courier,
      deliveryFee: deliveryFee,
      items: _orderItems,
    );

    _currentOrder.value = order;
    currentOrderId.value = order.id;

    print('Order created successfully: ${order.id}');
    showSnackbar('Pesanan berhasil dibuat');
    _isProcessingOrder.value = false;
    await fetchOngoingOrders(refresh: true);
  }

  Future<void> setSelectedAddress(int addressId) async {
    print('Setting selected address: $addressId');
    _selectedAddressId.value = addressId;

    if (!_isTakeAwaySelected.value && _couriers.isEmpty) {
      print('Loading couriers for delivery...');
      await loadCouriers();
    }

    if (!_isTakeAwaySelected.value && _canCreateOrder()) {
      print('Auto creating order with selected address...');
      await _createOrUpdateOrder();
    } else if (!_isTakeAwaySelected.value &&
        _selectedCourier.value == null &&
        _couriers.isNotEmpty) {
      print('Auto selecting first courier...');
      selectCourier(_couriers.first);
    }
  }

  //MENGAMBIL DATA CART
  Future<void> loadOrderItemsFromCart() async {
    try {
      final response = await _cartService.getCartItems();
      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['items'] != null) {
        List<dynamic> cartItems = response.data['data']['items'];
        _orderItems.clear();
        for (var cartItem in cartItems) {
          Map<String, dynamic> orderItem = {
            'product_id': cartItem['product_id'],
            'quantity': cartItem['quantity'],
            'price': _extractPrice(cartItem).toInt(),
            'note': cartItem['note'] ?? '',
          };

          if (cartItem['food_id'] != null) {
            orderItem['food_id'] = cartItem['food_id'];
          }
          if (cartItem['drink_id'] != null) {
            orderItem['drink_id'] = cartItem['drink_id'];
          }

          _orderItems.add(orderItem);
        }

        print('Order items loaded from cart: ${_orderItems.length}');

        if (_canCreateOrder()) {
          await _createOrUpdateOrder();
        }
      } else {
        _orderItems.clear();
        print('No cart items found');
      }
    } catch (e) {
      print('Error loading order items from cart: $e');
      showSnackbar('Gagal memuat item dari keranjang: $e', isError: true);
    }
  }

  double _extractPrice(Map<String, dynamic> item) {
    double price = 0.0;
    try {
      if (item['product'] != null && item['product']['price'] != null) {
        price = _parsePrice(item['product']['price'].toString());
      } else if (item['price'] != null) {
        price = _parsePrice(item['price'].toString());
      }
    } catch (e) {
      print('Error extracting price from item: $e');
    }
    return price;
  }

  double _parsePrice(String priceStr) {
    String cleanPrice =
        priceStr
            .replaceAll('Rp', '')
            .replaceAll('.', '')
            .replaceAll(',', '')
            .replaceAll(' ', '')
            .trim();
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  Future<void> navigateToDeliveryPage() async {
    final result = await Get.to(() => DeliveryPage(isSelectionMode: true));
    if (result != null) {
      if (result is Map<String, dynamic>) {
        if (result.containsKey('address_id')) {
          await setSelectedAddress(result['address_id']);
        }
      } else if (result == true) {
        print('Address selection completed');
      }
    }
    update();
  }

  void navigateToMenuPage() {
    Get.to(() => MenuPage());
  }

  Future<void> navigateToOrderStatusPage() async {
    try {
      _isProcessingOrder.value = true;
      if (_currentOrder.value == null) {
        print('No current order found, creating new order...');
        await _createOrUpdateOrder();
      }

      if (_currentOrder.value != null) {
        final orderId = _currentOrder.value!.id;
        print('Navigating to OrderStatusPage with orderId: $orderId');

        // Navigate to OrderStatusPage with the order ID
        Get.to(() => const OrderStatusPage(), arguments: {'orderId': orderId});
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('Error navigating to order status page: $e');
      showSnackbar('Gagal membuat pesanan: $e', isError: true);
    } finally {
      _isProcessingOrder.value = false;
    }
  }

  void showCourierOptionModal(BuildContext context) {
    if (_couriers.isEmpty) {
      loadCouriers();
    }
    showModalBottomCourierOption(context);
  }

  void showPaymentSummaryModal(BuildContext context) {
    showModalBottomPaymentSummary(context);
  }

  double get deliveryFee {
    if (_currentOrder.value != null &&
        _currentOrder.value!.deliveryFee != null) {
      return _currentOrder.value!.deliveryFee!.toDouble();
    }

    if (_orderDetail.value != null && _orderDetail.value!.deliveryFee != null) {
      return _orderDetail.value!.deliveryFee!.toDouble();
    }

    if (_isTakeAwaySelected.value) return 0.0;
    return selectedCourier?.fee.toDouble() ?? 0.0;
  }

  String get deliveryFeeFormatted {
    return deliveryFee > 0
        ? 'Rp${deliveryFee.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'
        : 'Gratis';
  }
  

  Future<void> loadCouriers() async {
    try {
      _isLoadingCouriers.value = true;
      print('Loading couriers...');

      final result = await _courierService.fetchCouriers();
      print('Couriers loaded: ${result.length}');

      _couriers.assignAll(result);
      if (_selectedCourier.value == null &&
          result.isNotEmpty &&
          !_isTakeAwaySelected.value) {
        selectCourier(result.first);
        print('Default courier selected: ${result.first.name}');
      }

      _isLoadingCouriers.value = false;
    } catch (e) {
      _isLoadingCouriers.value = false;
      print('Error loading couriers: $e');
      showSnackbar('Gagal memuat kurir: $e', isError: true);
    }
  }

  Future<void> selectCourier(CourierModel courier) async {
    _selectedCourier.value = courier;
    print('Courier selected: ${courier.name} - ${courier.fee}');

    if (!_isTakeAwaySelected.value && _canCreateOrder()) {
      print('Auto creating order with selected courier...');
      await _createOrUpdateOrder();
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadCouriers();
    loadOrderItemsFromCart();
    fetchOngoingOrders(refresh: true);
    fetchOrderHistory(refresh: true);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goBack() {
    Get.back();
  }

  void showSnackbar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }

  //PEMBAYARAN API
  Future<void> processPayment(int orderId) async {
    try {
      _isProcessingOrder.value = true;
      showSnackbar('Memproses pembayaran...');

      final response = await _orderService.generatePayment(orderId);

      if (response.statusCode == 200 && response.data != null) {
        final paymentData = response.data;
        final paymentUrl = response.data['url'];

        if (paymentUrl != null) {
          final result = await Get.to(
            () => PaymentWebViewPage(paymentUrl: paymentUrl, orderId: orderId),
          );

          if (result != null && result is Map<String, dynamic>) {
            final status = result['status'];

            switch (status) {
              case 'success':
                showSnackbar('Pembayaran berhasil!');
                await fetchOrderDetail(orderId);
                break;
              case 'failed':
                showSnackbar(
                  'Pembayaran gagal. Silakan coba lagi.',
                  isError: true,
                );
                break;
              case 'cancelled':
                showSnackbar('Pembayaran dibatalkan.', isError: true);
                break;
            }
          }
        } else {
          throw Exception('Payment URL not found in response');
        }
      } else {
        throw Exception('Failed to generate payment');
      }
    } catch (e) {
      print('Error processing payment: $e');
      showSnackbar('Gagal memproses pembayaran: $e', isError: true);
    } finally {
      _isProcessingOrder.value = false;
    }
  }

  //UNTUK BATALIN PAYMENT
  Future<void> cancelPayment(int orderId) async {
    try {
      _isProcessingOrder.value = true;
      showSnackbar('Membatalkan pembayaran...');

      final response = await _orderService.cancelPayment(orderId);

      if (response.statusCode == 200) {
        showSnackbar('Pembayaran berhasil dibatalkan');
        await fetchOrderDetail(orderId);
        Get.back();
      } else {
        throw Exception('Failed to cancel payment');
      }
    } catch (e) {
      print('Error cancelling payment: $e');
      showSnackbar('Gagal membatalkan pembayaran: $e', isError: true);
    } finally {
      _isProcessingOrder.value = false;
    }
  }
}
