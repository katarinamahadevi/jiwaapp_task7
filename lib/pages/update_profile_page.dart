import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/button_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_register.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Mahadevi Katarina',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'katarinamahadevi@gmail.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '6287853591966',
  );

  String _selectedGender = 'Perempuan';
  DateTime _selectedDate = DateTime(2004, 8, 18);
  String _selectedNationality = 'Indonesia';
  String _selectedOccupation = 'Pelajar / Mahasiswa';

  final List<String> _nationalities = ['Indonesia'];
  final List<String> _occupations = [
    'Pelajar / Mahasiswa',
    'Bekerja',
    'Lainnya',
  ];

  Widget _buildContainerTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool? obscureText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildContainerDropdown({
    required String value,
    required List<String> items,
    required String labelText,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildContainerDatePicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null && picked != _selectedDate) {
            setState(() {
              _selectedDate = picked;
            });
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Tanggal Lahir *',
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          child: Text(
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Ubah Profil'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildContainerTextField(
              controller: TextEditingController(),
              labelText: 'Sign Up Referral Code',
            ),
            const SizedBox(height: 16),

            _buildContainerTextField(
              controller: _nameController,
              labelText: 'Nama Kamu *',
            ),
            const SizedBox(height: 16),

            Text('Jenis Kelamin *', style: TextStyle(fontSize: 16)),
            RadioListTile<String>(
              title: Text('Laki-Laki'),
              value: 'Laki-Laki',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Perempuan'),
              value: 'Perempuan',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            _buildContainerDatePicker(context),
            const SizedBox(height: 16),

            _buildContainerTextField(
              controller: _emailController,
              labelText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            _buildContainerTextField(
              controller: _phoneController,
              labelText: 'Nomor Ponsel *',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            _buildContainerDropdown(
              value: _selectedNationality,
              items: _nationalities,
              labelText: 'Kewarganegaraan',
              onChanged: (value) {
                setState(() {
                  _selectedNationality = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            _buildContainerDropdown(
              value: _selectedOccupation,
              items: _occupations,
              labelText: 'Pekerjaan',
              onChanged: (value) {
                setState(() {
                  _selectedOccupation = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Ubah PIN container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ubah PIN', style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text('Ubah PIN'),
                              content: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Masukkan PIN Baru',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 15,
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Simpan'),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Text('Ubah', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hapus akun dengan icon
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('Hapus Akun'),
                        content: Text(
                          'Apakah Anda yakin ingin menghapus akun JIWA+?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Tambahkan logika hapus akun di sini
                            },
                            child: Text(
                              'Hapus',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline_outlined,
                    color: BaseColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Hapus akun JIWA+',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: ButtonPrimary(
        label: 'Simpan',
        onPressed: () {
          Navigator.pushNamed(context, '/halamanSelanjutnya');
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
