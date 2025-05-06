import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/appbar_primary.dart';
import 'package:jiwaapp_task7/widgets/button_payment.dart';
import 'package:jiwaapp_task7/widgets/button_payment_method.dart';
import 'package:jiwaapp_task7/widgets/modal_bottom_check_order.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedMethod = 'gopay';
  final TextEditingController _phoneController = TextEditingController(
    text: '8785359166',
  );
  final TextEditingController _cashtagController = TextEditingController();

  final List<Map<String, String>> paymentMethods = [
    {'label': 'GOPAY', 'value': 'gopay', 'asset': 'assets/logo/logo_gopay.png'},
    {
      'label': 'SHOPEEPAY / SPAYLATER',
      'value': 'shopeepay',
      'asset': 'assets/logo/logo_shopeepay.png',
    },
    {'label': 'OVO', 'value': 'ovo', 'asset': 'assets/logo/logo_ovo.png'},
    {
      'label': 'JENIUS PAY',
      'value': 'jenius',
      'asset': 'assets/logo/logo_jeniuspay.png',
    },
    {'label': 'DANA', 'value': 'dana', 'asset': 'assets/logo/logo_dana.jpg'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _cashtagController.dispose();
    super.dispose();
  }

  Widget _buildInputField() {
    switch (selectedMethod) {
      case 'ovo':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: BaseColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    'Masukkan nomor ponsel',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
      case 'jenius':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    'Masukkan cashtag',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '\$',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _cashtagController,
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
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarPrimary(title: 'Metode Pembayaran'),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              bottom: 300,
            ), // Beri space agar tidak ketutup tombol
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Text(
                  'E-Wallet',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ...paymentMethods.map((method) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.asset(
                              method['asset']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        method['label']!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Radio<String>(
                        value: method['value']!,
                        groupValue: selectedMethod,
                        activeColor: BaseColors.primary,
                        onChanged: (value) {
                          setState(() {
                            selectedMethod = value!;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedMethod = method['value']!;
                        });
                      },
                    ),
                    // Conditional input field directly under the selected method
                    if (selectedMethod == method['value']) _buildInputField(),
                  ],
                );
              }).toList(),
            ],
          ),

          // BottomPaymentPage ditempel di bawah
          ButtonPaymentMethod(
            onPressed: () => showModalBottomCheckOrder(context),
          ),
        ],
      ),
    );
  }
}
