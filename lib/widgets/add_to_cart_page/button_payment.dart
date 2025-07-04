import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//BUTTON PEMBAYARAN YANG LANGSUNG KE ORDER STATUS PAGE

class ButtonPayment extends StatefulWidget {
  final VoidCallback onPressed;
  final String assetPath;
  final bool isLoading;
  final bool isEnabled;
  const ButtonPayment({
    Key? key,
    required this.onPressed,
    this.assetPath = 'assets/image/image_announcement.png',
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<ButtonPayment> createState() => _ButtonPaymentState();
}

class _ButtonPaymentState extends State<ButtonPayment> {
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            _showTNCBottomSheet();
          };
  }

  void _showTNCBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text(
                'Syarat dan Ketentuan Take Away',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                '1. Harap ambil pesanan Anda tidak lebih dari 45 menit setelah melakukan order untuk menghindari penurunan kualitas produk.',
              ),
              const SizedBox(height: 8),
              const Text(
                '2. Pesanan yang tidak diambil akan dianggap terjual dan tidak dapat di-refund atau digantikan.',
              ),
              const SizedBox(height: 8),
              const Text(
                '3. Tunjukkan kode pick-up kepada staf/barista saat mengambil pesanan Anda.',
              ),
              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            decoration: const BoxDecoration(
              color: BaseColors.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: BaseColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(widget.assetPath, width: 30, height: 30),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      children: [
                        const TextSpan(
                          text:
                              'Dengan membayar pesanan, anda telah menyetujui ',
                        ),
                        TextSpan(
                          text: 'Syarat Dan Ketentuan',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            decorationColor: Colors.white,
                          ),
                          recognizer: _tapRecognizer,
                        ),
                        const TextSpan(text: ' Kami'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      widget.isEnabled && !widget.isLoading
                          ? widget.onPressed
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.isEnabled
                            ? BaseColors.primary
                            : Colors.grey[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child:
                      widget.isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            'Bayar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
