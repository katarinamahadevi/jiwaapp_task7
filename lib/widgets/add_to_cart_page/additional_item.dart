// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiwaapp_task7/controller/order_controller.dart';
// import 'package:jiwaapp_task7/theme/color.dart';

// Widget buildAdditionalItem() {
//         final OrderController controller = Get.put(OrderController());

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Tambahan Order',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 12,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Kantung Belanja',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Text(
//                         '+Rp3.500',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () => controller.toggleShoppingBag(),
//                         child: Container(
//                           width: 30,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: controller.isChecked
//                                 ? BaseColors.secondary
//                                 : Colors.white,
//                             border: Border.all(
//                               color: Colors.grey,
//                               width: 1.5,
//                             ),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: controller.isChecked
//                               ? const Icon(
//                                   Icons.check,
//                                   color: Colors.white,
//                                   size: 20,
//                                 )
//                               : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }