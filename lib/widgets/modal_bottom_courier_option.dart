import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

void showModalBottomCourierOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        String selectedCourier = 'GrabExpress';

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pilih Kurir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Divider(color: BaseColors.border),

                  const SizedBox(height: 10),
                  InkWell(
                    onTap:
                        () => setState(() => selectedCourier = 'GrabExpress'),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFB5D4BA),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/image/image_grab_express.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'GrabExpress',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          'Rp10.000',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Radio<String>(
                          value: 'GrabExpress',
                          groupValue: selectedCourier,
                          activeColor: BaseColors.primary,
                          onChanged:
                              (value) =>
                                  setState(() => selectedCourier = value!),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  InkWell(
                    onTap: () => setState(() => selectedCourier = 'GoSend'),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0BA90A),
                            shape: BoxShape.circle,
                          ),

                          child: Center(
                            child: Image.asset(
                              'assets/logo/logo_gosend.jpeg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text('GoSend', style: TextStyle(fontSize: 14)),
                        ),
                        Text(
                          'Rp10.500',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Radio<String>(
                          value: 'GoSend',
                          groupValue: selectedCourier,
                          activeColor: BaseColors.primary,
                          onChanged:
                              (value) =>
                                  setState(() => selectedCourier = value!),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  Divider(color: BaseColors.border),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, selectedCourier);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Konfirmasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }