import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiwaapp_task7/pages/profile_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/button_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_country_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_delete_account.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_occupation.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_verifyotp.dart';

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
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  String _selectedGender = 'Perempuan';
  DateTime _selectedDate = DateTime(2004, 8, 18);
  String _selectedNationality = 'Indonesia';
  String _selectedOccupation = 'Pelajar / Mahasiswa';

  final List<String> _nationalities = [
    'Indonesia',
    'Singapore',
    'Malaysia',
    'Vietnam',
    'Thailand',
    'Other',
  ];
  final List<String> _occupations = [
    'Pelajar / Mahasiswa',
    'Bekerja',
    'Dokter',
    'Pengusaha',
    'Ibu Rumah Tangga',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current values
    _dateController.text =
        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
    _countryController.text = _selectedNationality;
    _occupationController.text = _selectedOccupation;
  }

  Widget _buildContainerTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool? obscureText,
    bool enabled = true, // Add this parameter
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            enabled
                ? Colors.white
                : Colors
                    .grey
                    .shade200, // Change background based on enabled state
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        enabled: enabled, // Set enabled property
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: enabled ? Colors.black : Colors.grey,
          ), // Change text color
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Gray background color
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: TextEditingController(),
                enabled: false, // Disable the field
                decoration: InputDecoration(
                  labelText: 'Sign Up Referral Code',
                  labelStyle: TextStyle(color: Colors.grey), // Gray text
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            _buildContainerTextField(
              controller: _nameController,
              labelText: 'Nama Kamu *',
            ),
            const SizedBox(height: 16),

            Text('Jenis Kelamin *', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio<String>(
                        activeColor: BaseColors.primary,
                        value: 'Laki-Laki',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Laki-Laki'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio<String>(
                        activeColor: BaseColors.primary,
                        value: 'Perempuan',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Perempuan'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Updated Date of Birth field with modal
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir *',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  showBirthDatePickerModal(
                    context,
                    initialDate: _selectedDate,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                        _dateController.text = DateFormat(
                          'dd/MM/yyyy',
                        ).format(date);
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildContainerTextField(
              controller: _emailController,
              labelText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Gray background color
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _phoneController,
                enabled: false, // Disable the field
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Nomor Ponsel *',
                  labelStyle: TextStyle(color: Colors.grey), // Gray text
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Updated Nationality field with modal
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Kewarganegaraan',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
                readOnly: true,
                onTap: () {
                  showCountrySelectionModal(
                    context,
                    countries: _nationalities,
                    initialValue: _selectedNationality,
                    onCountrySelected: (country) {
                      setState(() {
                        _selectedNationality = country;
                        _countryController.text = country;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Updated Occupation field with modal
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _occupationController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
                readOnly: true,
                onTap: () {
                  showOccupationSelectionModal(
                    context,
                    occupation: _occupations,
                    initialValue: _selectedOccupation,
                    onOccupationSelected: (occupation) {
                      setState(() {
                        _selectedOccupation = occupation;
                        _occupationController.text = occupation;
                      });
                    },
                  );
                },
              ),
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
                      showVerifyOTPBottomSheet(context);
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
                showModalBottomDeleteAccount(context);
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _countryController.dispose();
    _occupationController.dispose();
    super.dispose();
  }
}

// Add these functions at the end of the file or in a utility file
void showBirthDatePickerModal(
  BuildContext context, {
  required Function(DateTime) onDateSelected,
  DateTime? initialDate,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => ModalBottomPickerdate(
          onDateSelected: onDateSelected,
          initialDate: initialDate,
        ),
  );
}

void showCountrySelectionModal(
  BuildContext context, {
  required List<String> countries,
  String? initialValue,
  required Function(String) onCountrySelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder:
              (_, scrollController) => ModalBottomCountryRegister(
                countries: countries,
                initialValue: initialValue,
                onCountrySelected: onCountrySelected,
              ),
        ),
  );
}

void showOccupationSelectionModal(
  BuildContext context, {
  required List<String> occupation,
  String? initialValue,
  required Function(String) onOccupationSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder:
              (_, scrollController) => ModalBottomOccupation(
                occupation: occupation,
                initialValue: initialValue,
                onOccupationSelected: onOccupationSelected,
              ),
        ),
  );
}
