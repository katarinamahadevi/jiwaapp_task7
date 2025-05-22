import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/forget_pin_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class ModalBottomPinForgetpin extends StatefulWidget {
  final Function(String) onPinComplete;
  final int pinLength;
  final String title;
  final String subtitle;
  
  const ModalBottomPinForgetpin({
    Key? key,
    required this.onPinComplete,
    this.pinLength = 6,
    this.title = 'Buat PIN',
    this.subtitle = 'Masukan 6 angka PIN untuk menjaga keamanan akun JIWA+',
  }) : super(key: key);
  
  @override
  State<ModalBottomPinForgetpin> createState() => _ModalBottomPinForgetpinState();
}

class _ModalBottomPinForgetpinState extends State<ModalBottomPinForgetpin> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final FocusNode _confirmPinFocusNode = FocusNode();
  
  final ForgetPinController _pinGetController = Get.find<ForgetPinController>();
  
  bool isConfirmingPin = false;
  String initialPin = '';
  String confirmPin = '';
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinFocusNode.requestFocus();
    });
    
    _pinController.addListener(_onPinChanged);
    _confirmPinController.addListener(_onConfirmPinChanged);
  }
  
  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _confirmPinController.removeListener(_onConfirmPinChanged);
    _pinController.dispose();
    _confirmPinController.dispose();
    _pinFocusNode.dispose();
    _confirmPinFocusNode.dispose();
    super.dispose();
  }
  
  void _onPinChanged() {
    setState(() {
      initialPin = _pinController.text;
    });
    if (_pinController.text.length == widget.pinLength) {
      _moveToConfirmPin();
    }
  }
  
  void _onConfirmPinChanged() {
    setState(() {
      confirmPin = _confirmPinController.text;
    });
    if (_confirmPinController.text.length == widget.pinLength) {
      _verifyPins();
    }
  }
  
  void _moveToConfirmPin() {
    setState(() {
      initialPin = _pinController.text;
      isConfirmingPin = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      _confirmPinFocusNode.requestFocus();
    });
  }
  
  void _verifyPins() {
    setState(() {
      confirmPin = _confirmPinController.text;
    });
    
    if (initialPin == confirmPin) {
      widget.onPinComplete(initialPin);
    } else {
      _confirmPinController.clear();
      setState(() {
        confirmPin = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN tidak cocok, silakan coba lagi')),
      );
    }
  }
  
  void _resetPinCreation() {
    setState(() {
      isConfirmingPin = false;
      initialPin = '';
      confirmPin = '';
    });
    _pinController.clear();
    _confirmPinController.clear();
    Future.delayed(const Duration(milliseconds: 300), () {
      _pinFocusNode.requestFocus();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isConfirmingPin ? 'Konfirmasi PIN' : widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (isConfirmingPin)
                TextButton(
                  onPressed: _resetPinCreation,
                  child: Text(
                    'Ubah',
                    style: TextStyle(color: BaseColors.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isConfirmingPin
                ? 'Masukkan kembali PIN Anda untuk konfirmasi'
                : widget.subtitle,
            style: const TextStyle(color: Colors.black87, fontSize: 16),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.pinLength,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color: isConfirmingPin
                      ? (index < confirmPin.length ? BaseColors.primary : Colors.transparent)
                      : (index < initialPin.length ? BaseColors.primary : Colors.transparent),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Show loading indicator when resetting PIN
          // Obx(() => _pinGetController.isResettingPin.value
          //   ? Center(child: CircularProgressIndicator(color: BaseColors.primary))
          //   : const SizedBox.shrink()
          // ),
          
          // Error message display if there's an error
          Obx(() => _pinGetController.errorMessage.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _pinGetController.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink()
          ),
          
          if (!isConfirmingPin)
            Opacity(
              opacity: 0,
              child: TextField(
                controller: _pinController,
                focusNode: _pinFocusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.pinLength),
                ],
                enableInteractiveSelection: false,
                autofocus: true,
                decoration: const InputDecoration(counterText: '', border: InputBorder.none),
              ),
            ),
          if (isConfirmingPin)
            Opacity(
              opacity: 0,
              child: TextField(
                controller: _confirmPinController,
                focusNode: _confirmPinFocusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(widget.pinLength),
                ],
                enableInteractiveSelection: false,
                autofocus: true,
                decoration: const InputDecoration(counterText: '', border: InputBorder.none),
              ),
            ),
        ],
      ),
    );
  }
}