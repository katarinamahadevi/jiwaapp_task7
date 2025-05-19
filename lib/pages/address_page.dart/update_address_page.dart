import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/controller/address_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/button_primary.dart';
import 'package:get/get.dart';

class UpdateAddressPage extends StatefulWidget {
  final Map<String, String> addressData;
  final int addressId;

  const UpdateAddressPage({
    super.key,
    required this.addressData,
    required this.addressId,
  });

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  late TextEditingController _labelController;
  late TextEditingController _addressTextController;
  late TextEditingController _noteController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  final AddressController _addressController = Get.find<AddressController>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.addressData['title']);
    _addressTextController = TextEditingController(
      text: widget.addressData['address'],
    );
    _noteController = TextEditingController(
      text: widget.addressData['note'] ?? '-',
    );
    _nameController = TextEditingController(text: widget.addressData['name']);
    _phoneController = TextEditingController(text: widget.addressData['phone']);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressTextController.dispose();
    _noteController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Ubah Alamat'),
      bottomNavigationBar: ButtonPrimary(
        label: _isLoading ? 'Menyimpan...' : 'Simpan',
        onPressed: _isLoading ? null : () => _saveAddress(),
      ),
      body: Obx(() {
        if (_addressController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_addressController.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terjadi kesalahan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(_addressController.errorMessage.value),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContainerTextField(
                      controller: _labelController,
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
                  address: widget.addressData['address'] ?? '',
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContainerTextField(
                      controller: _noteController,
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
                  controller: _nameController,
                  label: 'Nama Penerima *',
                  hint: 'Masukkan nama penerima',
                ),

                const SizedBox(height: 16),

                _buildPhoneField(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField({required String address}) {
    return Container(
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
                  address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            Padding(
              padding: const EdgeInsets.all(12),
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
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/image/image_bendera_indonesia.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text('+62', style: TextStyle(color: Colors.black)),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: '',
                    ),
                    style: const TextStyle(fontSize: 16),
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
    if (_labelController.text.isEmpty ||
        _addressTextController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field yang wajib diisi')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final double latitude =
          double.tryParse(widget.addressData['latitude'] ?? '0.0') ?? 0.0;
      final double longitude =
          double.tryParse(widget.addressData['longitude'] ?? '0.0') ?? 0.0;
      final Map<String, dynamic> addressData = {
        'label': _labelController.text,
        'address': _addressTextController.text,
        'latitude': latitude,
        'longitude': longitude,
        'note': _noteController.text,
        'recipient_name': _nameController.text,
        'phone_number':
            _phoneController.text.startsWith('0')
                ? _phoneController.text
                : '0${_phoneController.text}',
      };

      final success = await _addressController.updateAddress(
        widget.addressId,
        addressData,
      );

      if (success) {
        Navigator.pop(context, true); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alamat berhasil diperbarui')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_addressController.errorMessage.value)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
