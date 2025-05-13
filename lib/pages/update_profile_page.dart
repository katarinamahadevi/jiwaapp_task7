import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiwaapp_task7/controller/profile_controller.dart';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/button_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_country_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_delete_account.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_occupation.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_verifyotp.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final ProfileController _profileController = Get.put(ProfileController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  String _selectedGender = '';
  DateTime _selectedDate = DateTime.now();
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
    _loadUserData();
  }

  void _loadUserData() {
    _profileController.fetchUserData().then((_) {
      if (_profileController.user.value != null) {
        UserModel user = _profileController.user.value!;

        // Set text controllers with user data
        _nameController.text = user.name ?? '';
        _emailController.text = user.email ?? '';
        _phoneController.text = user.phoneNumber ?? '';
        _referralCodeController.text = user.referralCode ?? '';

        // Set gender
        setState(() {
          _selectedGender = user.gender ?? 'Perempuan';
        });

        // Set date of birth if available
        if (user.dateOfBirth != null) {
          try {
            _selectedDate = DateTime.parse(user.dateOfBirth!);
            _dateController.text = DateFormat(
              'dd/MM/yyyy',
            ).format(_selectedDate);
          } catch (e) {
            _dateController.text = '';
          }
        }

        // Set nationality and occupation
        _countryController.text = user.region ?? 'Indonesia';
        _selectedNationality = user.region ?? 'Indonesia';

        _occupationController.text = user.job ?? 'Pelajar / Mahasiswa';
        _selectedOccupation = user.job ?? 'Pelajar / Mahasiswa';
      }
    });
  }

  Widget _buildContainerTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool? obscureText,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: enabled ? Colors.black : Colors.grey),
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
      body: Obx(() {
        if (_profileController.isLoading.value) {
          // return Center(child: LoadingIndicator(color: BaseColors.primary));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Referral Code (disabled)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _referralCodeController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Sign Up Referral Code',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Name
              _buildContainerTextField(
                controller: _nameController,
                labelText: 'Nama Kamu *',
              ),
              const SizedBox(height: 16),

              // Gender
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

              // Date of Birth
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

              // Email
              _buildContainerTextField(
                controller: _emailController,
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Phone Number (disabled)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _phoneController,
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Nomor Ponsel *',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nationality
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

              // Occupation
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

              // Change PIN container
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
                        showModalBottomVerifyOTPRegister(context);
                      },
                      child: Text('Ubah', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Delete account
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
        );
      }),
      // bottomNavigationBar: Obx(() => ButtonPrimary(
      //   label: 'Simpan',
      //   onPressed: _profileController.isLoading.value ? null : _saveUserData,
      //   // isLoading: _profileController.isLoading.value,
      // )),
    );
  }

  void _saveUserData() {
    // Create updated user data
    Map<String, dynamic> updatedUserData = {
      'name': _nameController.text,
      'gender': _selectedGender,
      'date_of_birth': DateFormat('yyyy-MM-dd').format(_selectedDate),
      'email': _emailController.text,
      'nationality': _selectedNationality,
      'occupation': _selectedOccupation,
    };

    // Call the update user profile method in the controller
    _profileController.updateUserProfile(updatedUserData);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _countryController.dispose();
    _occupationController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }
}

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
