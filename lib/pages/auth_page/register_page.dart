import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/register_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/register_page/modal_bottom_country_register.dart';
import 'package:jiwaapp_task7/widgets/register_page/modal_bottom_occupation.dart';
import 'package:jiwaapp_task7/widgets/auth_page/modal_bottom_pin_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Kami ingin kenal kamu lebih\ndekat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Masukkan nama dan tanggal lahir kamu ya!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: controller.referralCodeController,
                decoration: InputDecoration(
                  labelText: 'Kode Referral (Opsional)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Kamu *',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Kelamin *',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      children: [
                        Radio<String>(
                          activeColor: BaseColors.primary,
                          value: 'Male', 
                          groupValue: controller.selectedGender.value,
                          onChanged: controller.setGender,
                        ),
                        const Text('Male'),
                        const SizedBox(width: 20),
                        Radio<String>(
                          activeColor: BaseColors.primary,
                          value: 'Female', 
                          groupValue: controller.selectedGender.value,
                          onChanged: controller.setGender,
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showCountryPicker(context),
                      child: Obx(
                        () => Row(
                          children: [
                            Image.asset(
                              controller.selectedFlagAsset.value,
                              width: 24,
                            ),
                            SizedBox(width: 6),
                            Text(
                              controller.selectedDialCode.value,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Nomor Ponsel',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),


              TextField(
                controller: controller.dateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir *',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: const Icon(Icons.event_available),
                ),
                readOnly: true,
                onTap: () => _showBirthDatePicker(context),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.countryController,
                decoration: InputDecoration(
                  labelText: 'Kewarganegaraan',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                ),
                readOnly: true,
                onTap: () => _showCountrySelectionModal(context),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: controller.occupationController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                ),
                readOnly: true,
                onTap: () => _showOccupationSelectionModal(context),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showModalBottomPin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Masukkan nama negara',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.phoneCountries.length,
                  itemBuilder: (context, index) {
                    final country = controller.phoneCountries[index];
                    return ListTile(
                      leading: Image.asset(country['flag']!, width: 32),
                      title: Text(country['name']!),
                      trailing: Text(country['code']!),
                      onTap: () {
                        controller.setPhoneCountry(country);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBirthDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => ModalBottomPickerdate(
            onDateSelected: controller.setDate,
            initialDate: controller.selectedDate.value,
          ),
    );
  }

  void _showCountrySelectionModal(BuildContext context) {
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
                  countries: controller.countries,
                  initialValue: controller.selectedCountry.value,
                  onCountrySelected: controller.setCountry,
                ),
          ),
    );
  }

  void _showOccupationSelectionModal(BuildContext context) {
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
                  occupation: controller.occupations,
                  initialValue: controller.selectedOccupation.value,
                  onOccupationSelected: controller.setOccupation,
                ),
          ),
    );
  }

  void _showModalBottomPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ModalBottomPinRegister(
            onPinComplete: (pin) {
              controller.processRegistration(pin);
            },
          ),
        );
      },
    );
  }
}
