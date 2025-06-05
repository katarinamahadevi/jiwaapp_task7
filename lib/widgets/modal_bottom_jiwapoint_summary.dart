// import 'package:flutter/material.dart';
// import 'package:jiwaapp_task7/theme/color.dart';

// void showModalBottomJiwaPointSummary(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 8),
//                 Container(
//                   height: 4,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Informasi Jiwa Point',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   '1. Jiwa Point yang tertulis pada halaman Checkout merupakan potensi Jiwa Point yang akan didapatkan.',
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   '2. Potensi Jiwa Point dihitung dari total nominal yang dibayarkan diluar pemakaian Jiwa Point.',
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   '3. Nominal Potensi dan Limit Jiwa Point yang dapat diperoleh akan berbeda untuk setiap levelnya dan dapat mengacu pada tabel di bawah ini:',
//                 ),
//                 const SizedBox(height: 20),
//                 _buildJiwaPointTable(),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
  
//   Widget _buildJiwaPointTable() {
//     return Table(
//       border: TableBorder.all(width: 1, color: Colors.black),
//       columnWidths: const {
//         0: FlexColumnWidth(2),
//         1: FlexColumnWidth(2),
//         2: FlexColumnWidth(2),
//         3: FlexColumnWidth(2),
//       },
//       children: const [
//         TableRow(
//           decoration: BoxDecoration(color: BaseColors.primary),
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 'Level',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 '% Jiwa Point',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 'Limit/\nTransaksi',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 'Limit/\nHari',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('Jiwa', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('2,5%', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('5.000', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('25.000', textAlign: TextAlign.center),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Teman Sejiwa',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('5%', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('7.500', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('37.500', textAlign: TextAlign.center),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Sahabat Sejiwa',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('7,5%', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('7.500', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('37.500', textAlign: TextAlign.center),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Saudara Sejiwa',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('10%', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('15.000', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('75.000', textAlign: TextAlign.center),
//             ),
//           ],
//         ),
//         TableRow(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Belahan Jiwa',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('15%', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('15.000', textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('75.000', textAlign: TextAlign.center),
//             ),
//           ],
//         ),
//       ],
//     );
//   }