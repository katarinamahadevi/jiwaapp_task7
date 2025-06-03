// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiwaapp_task7/controller/order_controller.dart';
// import 'package:jiwaapp_task7/pages/order_status_page.dart';
// import 'package:jiwaapp_task7/theme/color.dart';

// //MODAL BOTTOM KONFIRMASI CEK ULANG PESANAN

// Future<bool?> showModalBottomCheckOrder(BuildContext context) {
//   final OrderController orderController = Get.find<OrderController>();

//   return showModalBottomSheet<bool>(
//     backgroundColor: Colors.white,
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (_) {
//       return Obx(
//         () => Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.85,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   bottom: 80,
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 4,
//                         margin: const EdgeInsets.only(top: 20, bottom: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),

//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Periksa kembali pesanan kamu',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Anda akan membayar dan melakukan pesanan pada outlet dengan metode pemesanan di bawah ini :',
//                                   style: TextStyle(fontSize: 14),
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 40,
//                                       decoration: const BoxDecoration(
//                                         color: BaseColors.primary,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Center(
//                                         child: Image.asset(
//                                           orderController.isTakeAwaySelected
//                                               ? 'assets/image/image_take_away.png'
//                                               : 'assets/image/image_delivery.png',
//                                           width: 28,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       orderController.isTakeAwaySelected
//                                           ? 'Take Away'
//                                           : 'Delivery',
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 20),

//                                 // Outlet Information
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/image/image_outlet.png',
//                                       width: 40,
//                                       height: 40,
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 4,
//                                                     ),
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       BaseColors.greenContainer,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                 ),
//                                                 child: const Text(
//                                                   '0.55 km',
//                                                   style: TextStyle(
//                                                     color: Colors.green,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 10),
//                                               const Text(
//                                                 'KANNA HOMESTAY',
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 6),
//                                           const Text(
//                                             'Jl. Kelampis Semolo Timur 41 Rt 001 Rw 009 Kelurahan Semolowaru Kecamatan Sukolilo Kode Pos 60119 Surabaya',
//                                             style: TextStyle(fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 20),

//                                 // Courier Information (only for delivery)
//                                 if (!orderController.isTakeAwaySelected &&
//                                     orderController.selectedCourier !=
//                                         null) ...[
//                                   DottedLine(dashColor: BaseColors.border),
//                                   const SizedBox(height: 10),
//                                   const Text(
//                                     'Informasi Kurir',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.delivery_dining,
//                                         size: 24,
//                                         color: BaseColors.primary,
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         '${orderController.selectedCourier!.name} - ${orderController.deliveryFeeFormatted}',
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//                                 ],

//                                 DottedLine(dashColor: BaseColors.border),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   orderController.isTakeAwaySelected
//                                       ? 'Syarat dan Ketentuan Take Away'
//                                       : 'Syarat dan Ketentuan Delivery',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),

//                                 // Terms and Conditions
//                                 if (orderController.isTakeAwaySelected) ...[
//                                   ...[
//                                     'Tunjukkan kode pick up kepada staf/barista saat mengambil pesanan Anda di outlet.',
//                                     'Pesanan harus diambil sesuai dengan waktu yang telah ditentukan.',
//                                     'Pastikan untuk memeriksa kelengkapan pesanan sebelum meninggalkan outlet.',
//                                     'Pesanan yang tidak diambil dalam waktu 2 jam akan dianggap terjual dan tidak dapat di-refund.',
//                                   ].asMap().entries.map((entry) {
//                                     final idx = entry.key + 1;
//                                     final text = entry.value;
//                                     return Padding(
//                                       padding: const EdgeInsets.only(bottom: 8),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '$idx. ',
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               text,
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ] else ...[
//                                   ...[
//                                     'Harap pastikan alamat dan nomor telepon yang dimasukkan sudah benar dan dapat dihubungi oleh driver.',
//                                     'Customer harus mengambil produk yang dikembalikan oleh driver ke outlet jika tidak ada respons dari pembeli saat proses pengantaran. Outlet tidak berkewajiban mengantarkan kembali produk yang dikembalikan oleh driver.',
//                                     'Pesanan yang tidak diambil oleh customer apabila driver mengembalikan produk akan dianggap terjual dan tidak dapat di-refund atau digantikan.',
//                                     'Tunjukkan kode pick up kepada staf/barista saat mengambil pesanan Anda di outlet.',
//                                   ].asMap().entries.map((entry) {
//                                     final idx = entry.key + 1;
//                                     final text = entry.value;
//                                     return Padding(
//                                       padding: const EdgeInsets.only(bottom: 8),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '$idx. ',
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               text,
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ],
//                                 const SizedBox(height: 20),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Bottom Buttons
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     decoration: const BoxDecoration(color: Colors.white),
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed:
//                                 orderController.isProcessingOrder
//                                     ? null
//                                     : () {
//                                       Navigator.pop(context, false);
//                                     },
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: BaseColors.black),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 15),
//                             ),
//                             child: const Text(
//                               'Kembali',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed:
//                                 orderController.isProcessingOrder
//                                     ? null
//                                     : () async {
//                                       // Create order
//                                       final order =
//                                           await orderController.createOrder();
//                                       if (order != null) {
//                                         Navigator.pop(context, true);
//                                         // Navigate to order status page
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder:
//                                                 (context) => OrderStatusPage(),
//                                           ),
//                                         );
//                                       }
//                                     },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFE25C4B),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 15),
//                             ),
//                             child:
//                                 orderController.isProcessingOrder
//                                     ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                               Colors.white,
//                                             ),
//                                       ),
//                                     )
//                                     : const Text(
//                                       'Bayar',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
