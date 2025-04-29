import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiwaapp_task7/pages/home_page.dart';
import 'package:jiwaapp_task7/theme/color.dart';

class ModalBottomPin extends StatefulWidget {
  final Function(String) onPinComplete;
  final int pinLength;
  final String title;
  final String subtitle;

  const ModalBottomPin({
    Key? key,
    required this.onPinComplete,
    this.pinLength = 6,
    this.title = 'Buat PIN',
    this.subtitle = 'Masukan 6 angka PIN untuk menjaga keamanan akun JIWA+',
  }) : super(key: key);

  @override
  State<ModalBottomPin> createState() => _ModalBottomPinState();
}

class _ModalBottomPinState extends State<ModalBottomPin> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    // Listen to changes in the text field
    _pinController.addListener(_onPinChanged);
  }

  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onPinChanged() {
    setState(() {});

    // Check if PIN is complete
    if (_pinController.text.length == widget.pinLength) {
      widget.onPinComplete(_pinController.text);

      // Navigasi ke halaman Home setelah PIN selesai diisi
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
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
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 80),
          // PIN indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.pinLength,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  color:
                      index < _pinController.text.length
                          ? BaseColors.primary
                          : Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Invisible TextField untuk menerima input dari keyboard perangkat
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _pinController,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.pinLength),
              ],
              // Ini untuk memastikan keyboard tetap terbuka
              enableInteractiveSelection: false,
              autofocus: true,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
