import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/widgets/order_page/modal_bottom_cancel_order.dart';

//BUTTON ORDER STATUS DETAIL

class ButtonStatusPayment extends StatefulWidget {
  final Function()? onCancelPayment;
  final Function()? onContinuePayment;
  final int timeoutSeconds;
  final int orderId;
final VoidCallback onCancelSuccess;
final Function(String message, {bool isError}) showSnackbar;
final Future<void> Function(int orderId) cancelPaymentFunction;
  

  const ButtonStatusPayment({
    Key? key,
    this.onCancelPayment,
    this.onContinuePayment,
    this.timeoutSeconds = 300,
      required this.orderId,
  required this.onCancelSuccess,
  required this.showSnackbar,
  required this.cancelPaymentFunction,
  }) : super(key: key);

  @override
  State<ButtonStatusPayment> createState() => _ButtonStatusPaymentState();
}

class _ButtonStatusPaymentState extends State<ButtonStatusPayment> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timeoutSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          // Optionally handle timeout
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => showModalBottomCancelOrder(
    context,
    orderId: widget.orderId,
    onCancelSuccess: widget.onCancelSuccess,
    showSnackbar: widget.showSnackbar,
    cancelPaymentFunction: widget.cancelPaymentFunction,
  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: BorderSide(color: Colors.black),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Batalkan Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: widget.onContinuePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: Text(
                'Lanjutkan Pembayaran (${_formatTime()})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
