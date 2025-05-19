import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/address_model.dart';
import 'package:jiwaapp_task7/services/address_service.dart';

class AddressController extends GetxController {
  final AddressService _addressService = Get.find<AddressService>();

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var addresses = <AddressModel>[].obs;
  var selectedAddressId = RxnInt();

  final labelController = TextEditingController();
  final noteController = TextEditingController(text: '-');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressData = Rx<Map<String, dynamic>>({});

  bool get isFormValid =>
      labelController.text.isNotEmpty &&
      addressData.value['address'] != null &&
      nameController.text.isNotEmpty &&
      phoneController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  @override
  void onClose() {
    labelController.dispose();
    noteController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void initAddressData(Map<String, dynamic> data) {
    addressData.value = data;
  }

  void resetForm() {
    labelController.clear();
    noteController.text = '-';
    nameController.clear();
    phoneController.clear();
    addressData.value = {};
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final result = await _addressService.getAddresses();
      addresses.assignAll(result);

      if (selectedAddressId.value != null) {
        final stillExists = addresses.any(
          (address) => address.id == selectedAddressId.value,
        );
        if (!stillExists) {
          selectedAddressId.value = null;
        }
      }
      if (selectedAddressId.value == null && addresses.isNotEmpty) {
        selectedAddressId.value = addresses.first.id;
      }
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addAddress() async {
    if (!isFormValid) return false;

    try {
      isLoading(true);

      final Map<String, dynamic> data = {
        "label": labelController.text,
        "address": addressData.value['address'],
        "latitude": double.tryParse(addressData.value['latitude'].toString()),
        "longitude": double.tryParse(addressData.value['longitude'].toString()),
        "note": noteController.text,
        "recipient_name": nameController.text,
        "phone_number": '+62${phoneController.text}',
      };

      final newAddress = await _addressService.addAddress(data);
      addresses.add(newAddress);

      if (addresses.length == 1) {
        selectedAddressId.value = newAddress.id;
      }

      return true;
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> updateAddress(int id, Map<String, dynamic> addressData) async {
    try {
      isLoading(true);
      final updatedAddress = await _addressService.updateAddress(
        id,
        addressData,
      );

      final index = addresses.indexWhere((address) => address.id == id);
      if (index != -1) {
        addresses[index] = updatedAddress;
      }

      return true;
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteAddress(int id) async {
    try {
      isLoading(true);
      await _addressService.deleteAddress(id);

      addresses.removeWhere((address) => address.id == id);

      if (selectedAddressId.value == id) {
        selectedAddressId.value =
            addresses.isNotEmpty ? addresses.first.id : null;
      }

      return true;
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

  void selectAddress(int id) {
    selectedAddressId.value = id;
  }

  AddressModel? get selectedAddress {
    if (selectedAddressId.value == null) return null;

    try {
      return addresses.firstWhere(
        (address) => address.id == selectedAddressId.value,
      );
    } catch (_) {
      return null;
    }
  }
}
