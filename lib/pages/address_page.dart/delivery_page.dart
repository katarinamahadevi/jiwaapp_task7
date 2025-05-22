import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/model/address_model.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/search_location_page.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/update_address_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_delete_address.dart';

class DeliveryPage extends GetView<AddressController> {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.greyBG,
      appBar: AppbarPrimary(title: 'Alamat Tersimpan'),
      body: Column(
        children: [
          _buildAddAddressButton(context),
          SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Terjadi kesalahan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(controller.errorMessage.value),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.fetchAddresses(),
                        child: Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.addresses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/image_empty.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada alamat tersimpan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tambahkan alamat favoritmu untuk memudahkan pengiriman',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchAddresses(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.addresses.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final address = controller.addresses[index];
                    final isSelected =
                        controller.selectedAddressId.value == address.id;

                    return _buildAddressItem(
                      context: context,
                      address: address,
                      isHighlighted: isSelected,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchLocationPage()),
          );
        },
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: BaseColors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: Colors.white, size: 24),
        ),
        title: Text(
          'Tambah Alamat',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Simpan alamat favorit yang kamu mau di sini',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black54),
      ),
    );
  }

  Widget _buildAddressItem({
    required BuildContext context,
    required AddressModel address,
    bool isHighlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
        border:
            isHighlighted
                ? Border.all(color: BaseColors.primary, width: 2)
                : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 25, 0, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          backgroundColor: BaseColors.primary,
                          child: Image.asset(
                            'assets/image/image_address.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          address.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 12, 16, 12),
                  child: Text(
                    '${address.recipientName} - ${address.phoneNumber}',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 16, 0),
                  child: Text(
                    address.address,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      height: 1.4,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(60, 16, 16, 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Catatan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.article,
                            color: Colors.grey.shade400,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              address.note.isNotEmpty ? address.note : '-',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UpdateAddressPage(
                              addressData: {
                                'title': address.label,
                                'address': address.address,
                                'name': address.recipientName,
                                'phone': address.phoneNumber,
                                'note': address.note,
                                'latitude': address.latitude.toString(),
                                'longitude': address.longitude.toString(),
                              },
                              addressId: address.id,
                            ),
                      ),
                    ).then((result) {
                      if (result == true) {}
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    child: CircleAvatar(
                      backgroundColor: BaseColors.greyBG,
                      child: Image.asset(
                        'assets/image/image_update.png',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomDeleteAddress(context, address.id);
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    child: CircleAvatar(
                      backgroundColor: BaseColors.greyBG,
                      child: Image.asset(
                        'assets/image/image_delete.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                if (!isHighlighted) ...[
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      controller.selectAddress(address.id);
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: CircleAvatar(
                        backgroundColor: BaseColors.greyBG,
                        child: Icon(
                          Icons.check_circle_outline,
                          color: BaseColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
