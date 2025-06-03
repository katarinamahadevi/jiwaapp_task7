import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/model/courier_model.dart';
import 'package:jiwaapp_task7/model/order_model.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/delivery_page.dart';
import 'package:jiwaapp_task7/pages/menu_page/menu_page.dart';
import 'package:jiwaapp_task7/pages/order_status_page.dart';
import 'package:jiwaapp_task7/services/courier_service.dart';
import 'package:jiwaapp_task7/services/order_service.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_courier_option.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_payment_summary.dart';

class OrderController extends GetxController {
  final _isTakeAwaySelected = true.obs;
  final _couriers = <CourierModel>[].obs;
  final _selectedCourier = Rxn<CourierModel>();
  final _isLoadingCouriers = false.obs;
  final _isProcessingOrder = false.obs;
  final _selectedAddressId = 0.obs;
  final _orderItems = <Map<String, dynamic>>[].obs;
  final _currentOrder = Rxn<OrderModel>();
  final _orderDetail = Rxn<OrderModel>();
  final _isLoadingOrderDetail = false.obs;

  final _ongoingOrders = <OrderModel>[].obs;
  final _orderHistory = <OrderModel>[].obs;
  final _isLoadingOrders = false.obs;
  final _currentPage = 1.obs;
  final _hasMoreData = true.obs;

  final CourierService _courierService = CourierService();
  final OrderService _orderService = OrderService();
  final CartService _cartService = CartService();

  bool get isLoadingCouriers => _isLoadingCouriers.value;
  bool get isProcessingOrder => _isProcessingOrder.value;
  bool get isLoadingOrders => _isLoadingOrders.value;
  List<CourierModel> get couriers => _couriers;
  CourierModel? get selectedCourier => _selectedCourier.value;
  bool get isTakeAwaySelected => _isTakeAwaySelected.value;
  int get selectedAddressId => _selectedAddressId.value;
  List<Map<String, dynamic>> get orderItems => _orderItems;
  OrderModel? get currentOrder => _currentOrder.value;
  List<OrderModel> get ongoingOrders => _ongoingOrders;
  List<OrderModel> get orderHistory => _orderHistory;
  bool get hasMoreData => _hasMoreData.value;
  OrderModel? get orderDetail => _orderDetail.value;
  bool get isLoadingOrderDetail => _isLoadingOrderDetail.value;

  final RxInt currentOrderId = 0.obs;

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

  //MENGAMBIL DATA ONGOING ORDER
  Future<void> fetchOngoingOrders({bool refresh = false}) async {
    if (refresh) {
      _currentPage.value = 1;
      _hasMoreData.value = true;
      _ongoingOrders.clear();
    }

    if (_isLoadingOrders.value || !_hasMoreData.value) return;

    try {
      _isLoadingOrders.value = true;

      final response = await _orderService.getOrders(page: _currentPage.value);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['orders'];
        if (data != null && data['data'] != null) {
          List<dynamic> ordersData = data['data'];
          List<OrderModel> fetchedOrders =
              ordersData
                  .map((orderJson) => OrderModel.fromJson(orderJson))
                  .where((order) => _isOngoingOrder(order.orderStatus))
                  .toList();

          if (refresh) {
            _ongoingOrders.assignAll(fetchedOrders);
          } else {
            _ongoingOrders.addAll(fetchedOrders);
          }
          _hasMoreData.value = data['next_page_url'] != null;
          if (_hasMoreData.value) {
            _currentPage.value++;
          }
        }
      }
    } catch (e) {
      print('Error fetching ongoing orders: $e');
      showSnackbar('Failed to load ongoing orders: $e', isError: true);
    } finally {
      _isLoadingOrders.value = false;
    }
  }

  // FETCH ORDER HISTORY
  Future<void> fetchOrderHistory({bool refresh = false}) async {
    if (refresh) {
      _currentPage.value = 1;
      _hasMoreData.value = true;
      _orderHistory.clear();
    }

    if (_isLoadingOrders.value || !_hasMoreData.value) return;

    try {
      _isLoadingOrders.value = true;

      final response = await _orderService.getOrders(page: _currentPage.value);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['orders'];
        if (data != null && data['data'] != null) {
          List<dynamic> ordersData = data['data'];
          List<OrderModel> fetchedOrders =
              ordersData
                  .map((orderJson) => OrderModel.fromJson(orderJson))
                  .where((order) => !_isOngoingOrder(order.orderStatus))
                  .toList();

          if (refresh) {
            _orderHistory.assignAll(fetchedOrders);
          } else {
            _orderHistory.addAll(fetchedOrders);
          }

          // Check if there's more data
          _hasMoreData.value = data['next_page_url'] != null;
          if (_hasMoreData.value) {
            _currentPage.value++;
          }
        }
      }
    } catch (e) {
      print('Error fetching order history: $e');
      showSnackbar('Failed to load order history: $e', isError: true);
    } finally {
      _isLoadingOrders.value = false;
    }
  }

  bool _isOngoingOrder(String status) {
    const ongoingStatuses = ['Pending'];
    return ongoingStatuses.contains(status);
  }

  String formatPrice(int price) {
    return 'Rp${totalPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

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

  //ICON DELIVERY DAN TAKE AWAY
  String getDeliveryIconAsset(String orderType) {
    return orderType.toLowerCase() == 'delivery'
        ? 'assets/image/image_take_away.png'
        : 'assets/image/image_delivery.png';
  }

  // BUAT TOGGLE DELIVERY DAN TAKEAWAY KESIMPEN DI API POST
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

  // TAKEAWAY TIDAK PERLU ADDRESS DAN KURIR
  bool _canCreateOrder() {
    if (_isTakeAwaySelected.value) {
      return _orderItems.isNotEmpty;
    } else {
      return _orderItems.isNotEmpty &&
          _selectedAddressId.value > 0 &&
          _selectedCourier.value != null;
    }
  }

  // MEMBUAT PESANAN (PAKE API POST ORDER)
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

  // UNTUK MILIH ALAMAT
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

  // GET CART DI ORDER (DETAIL PESANAN)
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

  void navigateToOrderStatusPage() {
    if (_currentOrder.value != null) {
      Get.to(
        () => OrderStatusPage(),
        arguments: {'orderId': _currentOrder.value!.id},
      );
    } else {
      _createOrUpdateOrder().then((_) {
        if (_currentOrder.value != null) {
          Get.to(
            () => OrderStatusPage(),
            arguments: {'orderId': _currentOrder.value!.id},
          );
        }
      });
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
    if (_isTakeAwaySelected.value) return 0.0;
    return selectedCourier?.fee.toDouble() ?? 0.0;
  }

  String get deliveryFeeFormatted {
    return deliveryFee > 0
        ? 'Rp${deliveryFee.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'
        : 'Gratis';
  }

  int get subtotalPrice {
    int total = 0;
    for (var item in _orderItems) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }
    return total;
  }

  int get totalPrice {
    return subtotalPrice + deliveryFee.toInt();
  }

  String get subtotalPriceFormatted {
    return 'Rp${subtotalPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  String get totalPriceFormatted {
    return 'Rp${totalPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
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
}
