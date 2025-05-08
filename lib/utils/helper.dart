// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Helpers {
//   static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
//     return DateFormat(format).format(date);
//   }

//   static String formatPhoneNumber(String phoneNumber) {
//     // Simple phone formatting, can be made more complex for different formats
//     if (phoneNumber.length < 5) return phoneNumber;
    
//     var cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');
//     if (cleaned.startsWith('0')) {
//       cleaned = cleaned.substring(1);
//     }
//     return '+62 ${cleaned.substring(0, cleaned.length >= 4 ? 4 : cleaned.length)} ${cleaned.substring(cleaned.length >= 4 ? 4 : cleaned.length)}';
//   }
  
//   static String capitalizeFirstLetter(String text) {
//     if (text.isEmpty) return text;
//     return text[0].toUpperCase() + text.substring(1).toLowerCase();
//   }
// }