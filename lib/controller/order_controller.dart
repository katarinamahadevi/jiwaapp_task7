import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/model/courier_model.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/delivery_page.dart';
import 'package:jiwaapp_task7/pages/menu_page/menu_page.dart';
import 'package:jiwaapp_task7/pages/my_voucher_page.dart';
import 'package:jiwaapp_task7/pages/outlet_options_page.dart';
import 'package:jiwaapp_task7/pages/payment_method_page.dart';
import 'package:jiwaapp_task7/services/courier_service.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_check_order.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_courier_option.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_jiwapoint_summary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_payment_summary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_time_option.dart';

class OrderController extends GetxController {
  final _isTakeAwaySelected = true.obs;
  final _selectedTime = 'Ambil Sekarang'.obs;
  final _jiwaPointActive = false.obs;
  final _isChecked = false.obs;
  final _hasSelectedPayment = false.obs;
  final _selectedPaymentMethod = ''.obs;
  final _selectedPaymentAmount = 'Rp42.500'.obs;
  final _selectedPaymentLogoPath = ''.obs;
  final _quantity = 1.obs;
  final _couriers = <CourierModel>[].obs;
  final _selectedCourier = Rxn<CourierModel>();
  final _isLoadingCouriers = false.obs;
  bool get isLoadingCouriers => _isLoadingCouriers.value;

  List<CourierModel> get couriers => _couriers;
  CourierModel? get selectedCourier => _selectedCourier.value;
  bool get isTakeAwaySelected => _isTakeAwaySelected.value;
  String get selectedTime => _selectedTime.value;
  bool get jiwaPointActive => _jiwaPointActive.value;
  bool get isChecked => _isChecked.value;
  bool get hasSelectedPayment => _hasSelectedPayment.value;
  String get selectedPaymentMethod => _selectedPaymentMethod.value;
  String get selectedPaymentAmount => _selectedPaymentAmount.value;
  String get selectedPaymentLogoPath => _selectedPaymentLogoPath.value;
  int get quantity => _quantity.value;
  final RxInt currentOrderId = 0.obs;

  void toggleDeliveryOption(bool isTakeAway) {
    _isTakeAwaySelected.value = isTakeAway;
  }

  void updateSelectedTime(String time) {
    _selectedTime.value = time;
  }

  void toggleJiwaPoint(bool isActive) {
    _jiwaPointActive.value = isActive;
  }

  void toggleShoppingBag() {
    _isChecked.value = !_isChecked.value;
  }

  void incrementQuantity() {
    _quantity.value++;
  }

  void decrementQuantity() {
    if (_quantity.value > 1) {
      _quantity.value--;
    }
  }

  void updatePaymentMethod({
    required String method,
    required String logoPath,
    String? amount,
  }) {
    _hasSelectedPayment.value = true;
    _selectedPaymentMethod.value = method;
    _selectedPaymentLogoPath.value = logoPath;
    if (amount != null) {
      _selectedPaymentAmount.value = amount;
    }
  }

  void resetPaymentMethod() {
    _hasSelectedPayment.value = false;
    _selectedPaymentMethod.value = '';
    _selectedPaymentLogoPath.value = '';
  }

  void navigateToOutletOptions() {
    Get.to(() => OutletOptionsPage());
  }

  void navigateToDeliveryPage() {
    Get.to(() => DeliveryPage());
  }

  void navigateToMenuPage() {
    Get.to(() => MenuPage());
  }

  void navigateToVoucherPage() {
    Get.to(() => MyVoucherPage());
  }

  Future<void> navigateToPaymentMethod() async {
    final result = await Get.to(() => PaymentMethodPage());

    if (result != null && result is Map<String, dynamic>) {
      updatePaymentMethod(
        method: result['method'],
        logoPath: result['logoPath'],
      );
    }
  }

  void showTimeOptionModal(BuildContext context) {
    showModalBottomTimeOption(context);
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

  void showJiwaPointSummaryModal(BuildContext context) {
    showModalBottomJiwaPointSummary(context);
  }

  void showCheckOrderModal(BuildContext context) {
    showModalBottomCheckOrder(context);
  }

  void updateMenuItem() {

  }

  void deleteMenuItem() {
    Get.defaultDialog(
      title: 'Hapus Item',
      middleText: 'Apakah Anda yakin ingin menghapus item ini?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
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

  bool get canProceedToPayment {
    return _quantity.value > 0 &&
        (_isTakeAwaySelected.value || deliveryAddressIsValid);
  }

  bool get deliveryAddressIsValid {
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    loadCouriers(); 
  }

  void _initializeData() {
    _selectedPaymentAmount.value = 'Rp42.500';
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

  final CourierService _courierService = CourierService();

  Future<void> loadCouriers() async {
    try {
      _isLoadingCouriers.value = true;
      print('Loading couriers...'); 

      final result = await _courierService.fetchCouriers();
      print('Couriers loaded: ${result.length}'); 

      _couriers.assignAll(result);
      if (_selectedCourier.value == null && result.isNotEmpty) {
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

  Future<void> reloadCouriers() async {
    _isLoadingCouriers.value = true;
    await loadCouriers();
    _isLoadingCouriers.value = false;
  }

  void selectCourier(CourierModel courier) {
    _selectedCourier.value = courier;
    print('Courier selected: ${courier.name} - ${courier.fee}'); 
    update(); 
  }
}