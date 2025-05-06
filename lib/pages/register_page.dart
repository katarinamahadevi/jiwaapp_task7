import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_country_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_occupation.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pin_register.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_pickerdate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _selectedGender;
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  final TextEditingController _countryController = TextEditingController();
  String? _selectedCountry;

  final TextEditingController _occupationController = TextEditingController();
  String? _selectedOccupation;

  final List<String> _countries = [
    'Indonesia',
    'Singapore',
    'Malaysia',
    'Vietnam',
    'Thailand',
    'Other',
  ];

  final List<String> _occupation = [
    'Dokter',
    'Pengusaha',
    'Ibu Rumah Tangga',
    'Mahasiswa',
    'Pelajar',
    'Other',
  ];

  String selectedCountry = 'Indonesia';
  String selectedDialCode = '+62';
  String selectedFlagAsset = 'assets/image/image_bendera_indonesia.png';
  final List<Map<String, String>> countries = [
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

  final TextEditingController phoneController = TextEditingController();
  bool isChecked = false;
  bool isButtonEnabled = false;

  void validateForm() {
    String phone = phoneController.text;
    setState(() {
      isButtonEnabled = phone.length >= 9 && isChecked;
    });
  }

  void showCountryPicker() {
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
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return ListTile(
                      leading: Image.asset(country['flag']!, width: 32),
                      title: Text(country['name']!),
                      trailing: Text(country['code']!),
                      onTap: () {
                        setState(() {
                          selectedCountry = country['name']!;
                          selectedDialCode = country['code']!;
                          selectedFlagAsset = country['flag']!;
                        });
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

  @override
  void initState() {
    super.initState();
    phoneController.addListener(validateForm);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

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
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: BaseColors.primary,
                        value: 'Laki-Laki',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      const Text('Laki-Laki'),
                      const SizedBox(width: 20),
                      Radio<String>(
                        activeColor: BaseColors.primary,
                        value: 'Perempuan',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      const Text('Perempuan'),
                    ],
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
                      onTap: showCountryPicker,
                      child: Row(
                        children: [
                          Image.asset(selectedFlagAsset, width: 24),
                          SizedBox(width: 6),
                          Text(
                            selectedDialCode,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),

                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
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
                controller: _dateController,
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
//TANGGAL LAHIR               
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
              const SizedBox(height: 16),

              TextField(
                controller: _countryController,
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
                onTap: () {
//KEWARGANEGARAAN
                  showCountrySelectionModal(
                    context,
                    countries: _countries,
                    initialValue: _selectedCountry,
                    onCountrySelected: (country) {
                      setState(() {
                        _selectedCountry = country;
                        _countryController.text = country;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _occupationController,
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
                onTap: () {
//PEKERJAAN
                  showOccupationSelectionModal(
                    context,
                    occupation: _occupation,
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
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showModalBottomPin(context);
                  },
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
}

//PICKERDATE TANGGAL LAHIR NAVIGASI KE MODAL BOTTOM PICKER DATE

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

//KEWARGANEGARAAN NAVIGASI KE MODAL BOTTOM COUNTRY

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

//PEKERJAAN NAVIGASI KE MODAL BOTTOM OCCUPATION
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


//PIN NAVIGASI KE MODAL BOTTOM PIN REGISTER
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
            print('PIN yang dimasukkan: $pin');
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
