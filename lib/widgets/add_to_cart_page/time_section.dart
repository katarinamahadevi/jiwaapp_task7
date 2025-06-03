// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiwaapp_task7/controller/order_controller.dart';
// import 'package:jiwaapp_task7/theme/color.dart';

// Widget buildTimeSection() {
//       final OrderController controller = Get.put(OrderController());

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Pilih Waktu',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             GestureDetector(
//               onTap: () => controller.showTimeOptionModal(Get.context!),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: Colors.grey.shade300,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.access_time,
//                       color: BaseColors.secondary,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         controller.selectedTime,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Colors.grey.shade600,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }