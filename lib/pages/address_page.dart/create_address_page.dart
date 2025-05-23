import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/pages/address_page.dart/find_location_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';

class CreateAddressPage extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const CreateAddressPage({super.key, required this.addressData});

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  final AddressController _addressController = Get.find<AddressController>();

  @override
  void initState() {
    super.initState();
    _addressController.initAddressData(widget.addressData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Tambah Alamat'),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContainerTextField(
                              controller: _addressController.labelController,
                              label: 'Label Alamat *',
                              hint: 'Masukkan label alamat',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Contoh: rumah, kantor, dan lainnya',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildAddressField(
                          address:
                              _addressController.addressData.value['address'] ??
                              '',
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContainerTextField(
                              controller: _addressController.noteController,
                              label: 'Catatan',
                              hint: 'Masukkan catatan tambahan',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Contoh: lantai, blok, nomor rumah',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildContainerTextField(
                          controller: _addressController.nameController,
                          label: 'Nama Penerima *',
                          hint: 'Masukkan nama penerima',
                        ),
                        const SizedBox(height: 16),
                        _buildPhoneField(),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _addressController.isFormValid &&
                                  !_addressController.isLoading.value
                              ? _saveAddress
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _addressController.isFormValid
                                ? BaseColors.primary
                                : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        _addressController.isLoading.value
                            ? 'Menyimpan...'
                            : 'Simpan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_addressController.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField({required String address}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindLocationPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              child: CircleAvatar(
                backgroundColor: BaseColors.primary,
                child: Image.asset(
                  'assets/image/image_location.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alamat',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    address.isNotEmpty ? address : 'Pilih lokasi',
                    style: TextStyle(
                      fontSize: 14,
                      color: address.isNotEmpty ? Colors.black87 : Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Nomor Ponsel',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(color: BaseColors.border),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/image/image_bendera_indonesia.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text('+62', style: TextStyle(color: Colors.black)),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: TextField(
                    controller: _addressController.phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: '',
                    ),
                    style: const TextStyle(fontSize: 16),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAddress() async {
    final success = await _addressController.addAddress();

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Alamat berhasil disimpan')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_addressController.errorMessage.value)),
      );
    }
  }
}
