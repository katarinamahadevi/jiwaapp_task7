
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ModalBottomRegister extends StatefulWidget {
//   final String phoneNumber;
//   final Function(String) onVerificationComplete;

//   const ModalBottomRegister({
//     Key? key,
//     required this.phoneNumber,
//     required this.onVerificationComplete,
//   }) : super(key: key);

//   @override
//   _ModalBottomRegisterState createState() => _ModalBottomRegisterState();
// }

// class _ModalBottomRegisterState extends State<ModalBottomRegister> {
//   final int otpLength = 4;
//   String currentOtp = '';
//   int _secondsRemaining = 30;
//   bool _canResend = false;
//   Timer? _timer;
  
//   // Controller untuk TextField tersembunyi
//   final TextEditingController _otpController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
    
//     _otpController.addListener(() {
//       setState(() {
//         currentOtp = _otpController.text;
//         if (currentOtp.length == otpLength) {
//           _verifyOtp();
//         }
//       });
//     });
    
//     Future.delayed(Duration(milliseconds: 100), () {
//       FocusScope.of(context).requestFocus(_focusNode);
//     });
//   }

//   void _startTimer() {
//     _secondsRemaining = 30;
//     _canResend = false;
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_secondsRemaining > 0) {
//           _secondsRemaining--;
//         } else {
//           _canResend = true;
//           timer.cancel();
//         }
//       });
//     });
//   }

//   void _verifyOtp() {
//     _focusNode.unfocus();
    
//     Future.delayed(Duration(milliseconds: 300), () {
//       widget.onVerificationComplete(currentOtp);
//     });
//   }

//   String _formatPhoneNumber(String number) {
//     // Format the phone number by adding +62 prefix if not exist
//     if (number.startsWith('+')) {
//       return number;
//     } else if (number.startsWith('0')) {
//       return '+62${number.substring(1)}';
//     } else {
//       return '+62$number';
//     }
//   }

//   String _formatTime(int seconds) {
//     return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _otpController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // Menangkap tap dimanapun untuk memunculkan keyboard
//       onTap: () {
//         FocusScope.of(context).requestFocus(_focusNode);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with close button
//             Padding(
//               padding: EdgeInsets.fromLTRB(24, 16, 16, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Verifikasi Nomor Ponsel Kamu',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
            
//             // OTP message
//             Padding(
//               padding: EdgeInsets.fromLTRB(24, 8, 24, 24),
//               child: Text(
//                 'Masukan OTP yang dikirimkan ke WhatsApp ${_formatPhoneNumber(widget.phoneNumber)}',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
            
//             // OTP input field indicators
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(otpLength, (index) {
//                   bool isActive = index == currentOtp.length;
//                   bool isFilled = index < currentOtp.length;
                  
//                   return Container(
//                     width: (MediaQuery.of(context).size.width - 64) / otpLength,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 40,
//                           alignment: Alignment.center,
//                           child: isFilled 
//                               ? Text(
//                                   currentOtp[index],
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 )
//                               : isActive 
//                                   ? Container(
//                                       width: 2,
//                                       height: 24,
//                                       color: Colors.black,
//                                     )
//                                   : null,
//                         ),
//                         Container(
//                           height: 2,
//                           color: isFilled 
//                               ? Colors.green 
//                               : isActive 
//                                   ? Colors.green 
//                                   : Colors.grey.shade300,
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
            
//             // Hidden TextField untuk input OTP
//             Opacity(
//               opacity: 0,
//               child: Container(
//                 width: 1,
//                 height: 1,
//                 child: TextField(
//                   controller: _otpController,
//                   focusNode: _focusNode,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(otpLength),
//                   ],
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.zero,
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Resend OTP
//             Padding(
//               padding: EdgeInsets.all(24),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: _canResend 
//                       ? () {
//                           setState(() {
//                             _otpController.clear();
//                           });
//                           _startTimer();
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('OTP dikirim ulang ke WhatsApp Anda')),
//                           );
//                         }
//                       : null,
//                   child: Text(
//                     _canResend 
//                         ? 'Kirim ulang OTP'
//                         : 'Kirim ulang OTP setelah ${_formatTime(_secondsRemaining)}',
//                     style: TextStyle(
//                       color: _canResend ? Colors.grey : Colors.grey.shade400,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
            
//             // Space for keyboard
//             SizedBox(height: 200),
//           ],
//         ),
//       ),
//     );
//   }
// }