import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiwaapp_task7/controller/profile_controller.dart';
import 'package:jiwaapp_task7/controller/update_pin_controller.dart';
import 'package:jiwaapp_task7/model/user_model.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_country_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_delete_account.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_occupation.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_verifyotp_register.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final ProfileController _profileController = Get.put(ProfileController());
  final updatePinController = Get.find<UpdatePinController>();

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
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phoneNumber;
        _referralCodeController.text = user.referralCode;

        setState(() {
          _selectedGender = user.gender;
        });

        try {
          _selectedDate = DateTime.parse(user.dateOfBirth!);
          _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
        } catch (e) {
          _dateController.text = '';
        }

        _countryController.text = user.region;
        _selectedNationality = user.region;
        _occupationController.text = user.job;
        _selectedOccupation = user.job;
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
          return Center(
            child: CircularProgressIndicator(color: BaseColors.primary),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text('Male'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          activeColor: BaseColors.primary,
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

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
                enabled: false,
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _phoneController,
                  enabled: true,
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

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PIN', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 4,
                                color: Colors.black,
                              ),
                            );
                          }),
                        ),
                        GestureDetector(
                          onTap: () {
                            final email = _emailController.text.trim();
                            if (email.isEmpty) {
                              Get.snackbar("Error", "Email tidak boleh kosong");
                              return;
                            }
                            updatePinController.sendOtp(email: email);
                          },
                          child: Text(
                            'Ubah',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

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
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed:
                _profileController.isLoading.value
                    ? null
                    : () => _saveUserData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: BaseColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text('Simpan'),
          ),
        ),
      ),
    );
  }

  void _saveUserData() {
    UserModel? currentUser = _profileController.user.value;
    Map<String, dynamic> updatedUserData = {
      'name': _nameController.text,
      'gender': _selectedGender,
      'date_of_birth': DateFormat('yyyy-MM-dd').format(_selectedDate),
      'email': _emailController.text,
      'region': _selectedNationality,
      'job': _selectedOccupation,
      'phone_number': currentUser?.phoneNumber ?? _phoneController.text,
      'referral_code':
          currentUser?.referralCode ?? _referralCodeController.text,
    };
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
