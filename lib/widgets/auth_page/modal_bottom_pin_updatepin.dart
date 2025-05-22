import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/update_pin_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';

void showModalBottomPinUpdatePin(BuildContext context) {
  ModalBottomPinUpdatePin.show(context);
}

class ModalBottomPinUpdatePin extends StatefulWidget {
  const ModalBottomPinUpdatePin({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ModalBottomPinUpdatePin(),
    );
  }

  @override
  State<ModalBottomPinUpdatePin> createState() => _ModalBottomPinUpdatePinState();
}

class _ModalBottomPinUpdatePinState extends State<ModalBottomPinUpdatePin> {
  final List<TextEditingController> _pinControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _pinFocusNodes = List.generate(6, (_) => FocusNode());
  final UpdatePinController _updatePinController = Get.find<UpdatePinController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pinFocusNodes.isNotEmpty) {
        _pinFocusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var focusNode in _pinFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onPinFilled() {
    final allFilled = _pinControllers.every((c) => c.text.isNotEmpty);
    if (allFilled) {
      FocusScope.of(context).unfocus();
      _updatePin();
    }
  }

  void _updatePin() {
    String pin = _pinControllers.map((c) => c.text).join('');
    _updatePinController.updatePin(newPin: pin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Buat PIN Baru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 18,
                  child: const Icon(Icons.close, size: 18, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Buat PIN baru untuk akun kamu',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 40,
                child: TextField(
                  controller: _pinControllers[index],
                  focusNode: _pinFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: BaseColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 5) {
                        _pinFocusNodes[index + 1].requestFocus();
                      } else {
                        _onPinFilled();
                      }
                    } else if (value.isEmpty && index > 0) {
                      _pinFocusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: _updatePinController.isLoading.value
                  ? null
                  : () {
                      final allFilled = _pinControllers.every((c) => c.text.isNotEmpty);
                      if (allFilled) {
                        _updatePin();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Silakan lengkapi PIN')),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _updatePinController.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Ubah PIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}