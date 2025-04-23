import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';

class UpdateLocationPage extends StatefulWidget {
  final Map<String, String> addressData;

  const UpdateLocationPage({super.key, required this.addressData});

  @override
  _UpdateLocationPageState createState() => _UpdateLocationPageState();
}

class _UpdateLocationPageState extends State<UpdateLocationPage> {
  late TextEditingController _labelController;
  late TextEditingController _addressController;
  late TextEditingController _noteController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.addressData['title']);
    _addressController = TextEditingController(
      text: widget.addressData['address'],
    );
    _noteController = TextEditingController(text: '-');
    _nameController = TextEditingController(text: widget.addressData['name']);
    _phoneController = TextEditingController(text: widget.addressData['phone']);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
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
      body: SingleChildScrollView(
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
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildAddressField(
                controller: _addressController,
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
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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

              ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField({
    required TextEditingController controller,
    required String address,
  }) {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              'Nomor Ponsel',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: BaseColors.border),
                      ),
                      child: Image.asset(
                        fit: BoxFit.fill,
                        'assets/image/image_bendera_indonesia.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '+62',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: BaseColors.black),

                    const SizedBox(width: 8),
                    Container(height: 24, width: 1, color: BaseColors.black),
                  ],
                ),
              ),
              hintText: 'Masukkan nomor ponsel',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _saveAddress() {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Alamat berhasil disimpan')));
  }
}
