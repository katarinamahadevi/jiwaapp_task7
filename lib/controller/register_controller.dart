import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/services/auth_service.dart';

class RegisterController extends GetxController {
  final TextEditingController referralCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString selectedGender = ''.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedCountry = ''.obs;
  final RxString selectedOccupation = ''.obs;
  final RxString selectedCountryPhone = 'Indonesia'.obs;
  final RxString selectedDialCode = '+62'.obs;
  final RxString selectedFlagAsset = 'assets/image/image_bendera_indonesia.png'.obs;
  final RxBool isChecked = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final AuthService _authService = AuthService();

//DATA DUMMY NEGARA
  final List<String> countries = [
    'Indonesia',
    'Singapore',
    'Malaysia',
    'Vietnam',
    'Thailand',
    'Other',
  ];

//DATA DUMMY PEKERJAAN
  final List<String> occupations = [
    'Dokter',
    'Pengusaha',
    'Ibu Rumah Tangga',
    'Mahasiswa',
    'Pelajar',
    'Other',
  ];

//DATA DUMMY TELEPON NEGARA
  final List<Map<String, String>> phoneCountries = [
    {
      'name': 'Afghanistan',
      'code': '+93',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Albania',
      'code': '+355',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Algeria',
      'code': '+213',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'American Samoa',
      'code': '+1684',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
    {
      'name': 'Indonesia',
      'code': '+62',
      'flag': 'assets/image/image_bendera_indonesia.png',
    },
  ];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments['email'] != null) {
      email.value = Get.arguments['email'];
    }

    phoneController.addListener(validateForm);
  }

  @override
  void onClose() {
    referralCodeController.dispose();
    nameController.dispose();
    dateController.dispose();
    countryController.dispose();
    occupationController.dispose();
    phoneController.dispose();
    super.onClose();
  }

//UNTUK VALIDASI PANJANG ANGKA TELEPON
  void validateForm() {
    String phone = phoneController.text;
    isButtonEnabled.value = phone.length >= 9 && isChecked.value;
  }

//UNTUK MEMILIH GENDER
  void setGender(String? value) {
    if (value != null) {
      selectedGender.value = value;
    }
  }
  
//UNTUK SET FORMAT TANGGAL 
  void setDate(DateTime date) {
    selectedDate.value = date;
    dateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

//UNTUK MEMILIH NEGARA
  void setCountry(String country) {
    selectedCountry.value = country;
    countryController.text = country;
  }

//UNTUK MEMILIH PEKERJAAN
  void setOccupation(String occupation) {
    selectedOccupation.value = occupation;
    occupationController.text = occupation;
  }
  
//UNTUK MEMILIH TELEPON NEGARA
  void setPhoneCountry(Map<String, String> country) {
    selectedCountryPhone.value = country['name']!;
    selectedDialCode.value = country['code']!;
    selectedFlagAsset.value = country['flag']!;
  }

  Map<String, dynamic> prepareUserData() {
    return {
      'name': nameController.text,
      'email': email.value,
      'gender': mapGender(selectedGender.value),
      'date_of_birth':
          selectedDate.value != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
              : '',
      'region': selectedCountry.value,
      'job': selectedOccupation.value,
      'phone_number': '${selectedDialCode.value}${phoneController.text}',
      'referral_code': referralCodeController.text,
      'referred_by': null,
    };
  }

  bool validateFormData() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Nama harus diisi');
      return false;
    }

    if (selectedGender.value.isEmpty) {
      Get.snackbar('Error', 'Jenis kelamin harus dipilih');
      return false;
    }

    if (phoneController.text.isEmpty || phoneController.text.length < 9) {
      Get.snackbar('Error', 'Nomor ponsel tidak valid');
      return false;
    }

    if (selectedDate.value == null) {
      Get.snackbar('Error', 'Tanggal lahir harus diisi');
      return false;
    }


    return true;
  }

  String mapGender(String gender) {
    return gender;
  }


//JIKA FORM SUDAH SELESAI TERISI MAKA AKAN LANJUT MENGISI PIN DAN JIKA SUDAH LANGSUNG NAVIGASI KE HOMEPAGE
  Future<void> processRegistration(String pin) async {
    if (!validateFormData()) return;

    isLoading.value = true;

    try {
      Map<String, dynamic> userData = prepareUserData();
      final registerResponse = await _authService.register(userData);

      final pinResponse = await _authService.createPin(email.value, pin);

      isLoading.value = false;

      Get.offAll(() => HomePage());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}');
    }
  }
}
