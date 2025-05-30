// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:jiwaapp_task7/pages/menu_page/detail_menu_page.dart';
// import 'package:jiwaapp_task7/pages/menu_page/menu_page.dart';
// import 'package:jiwaapp_task7/theme/color.dart';

// // cara manggil: 
// // Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder:
// //                           (context) => const DetailMenucomboPage(
// //                             title: 'Combo A',
// //                             description: 'Delicious sandwich with toppings',
// //                             imageUrl: 'assets/image/image_menu.png',
// //                             price: 25000.0,
// //                           ),
// //                     ),
// //                   );

// //MENU COMBO

// class DetailMenucomboPage extends StatefulWidget {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final double price;

//   const DetailMenucomboPage({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.price,
//   }) : super(key: key);

//   @override
//   State<DetailMenucomboPage> createState() => _DetailMenucomboPageState();
// }

// class _DetailMenucomboPageState extends State<DetailMenucomboPage> {
//   String selectedItem = 'Egg and cheese';
//   final List<Map<String, dynamic>> itemOptions = [
//     {'name': 'Egg and cheese', 'price': 0},
//     {'name': 'Spicy Bulgogi', 'price': 12000},
//     {'name': 'Smoked Beef and Cheese', 'price': 12000},
//     {'name': 'Crispy Chicken Mentai', 'price': 12000},
//     {'name': 'Creamy Egg Truffle', 'price': 5000},
//   ];
//   List<ToppingOption> toppings = [
//     ToppingOption(
//       name: "Cheese Slice",
//       imagePath: "assets/image/image_cheese.png",
//       price: 6000,
//     ),
//     ToppingOption(
//       name: "Omelette",
//       imagePath: "assets/image/image_cheese.png",
//       price: 6000,
//     ),
//     ToppingOption(
//       name: "Japanese Curry Sauce",
//       imagePath: "assets/image/image_cheese.png",
//       price: 6000,
//     ),
//   ];

//   int quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       quantity++;
//     });
//   }

//   void decrementQuantity() {
//     if (quantity > 1) {
//       setState(() {
//         quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 8,
//               offset: const Offset(0, 0),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Rp${widget.price.toInt()}.000',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: decrementQuantity,
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.remove),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 40,
//                       child: Text(
//                         quantity.toString(),
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: incrementQuantity,
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.add),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: () {
//                   double totalPrice = widget.price * quantity;

//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) => MenuPage(
//                             showStackViewOrder: true,
//                             totalPrice: totalPrice,
//                             itemCount: quantity,
//                           ),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: BaseColors.primary,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Tambah ke Keranjang',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 16.0,
//                   ),
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.pop(context),
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.black,
//                           size: 18,
//                         ),
//                       ),
//                       const SizedBox(width: 24),
//                       Text(
//                         widget.title,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 10,
//                 color: Colors.grey[100],
//               ),

//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(32.0),
//                           child: Image.asset(
//                             widget.imageUrl,
//                             height: 180,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: BaseColors.primary,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.directions_walk,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE56257),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.delivery_dining,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Text(
//                             widget.title,
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             widget.description,
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey[500],
//                               height: 1.5,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: _buildItemOptions(
//                     'Item 1',
//                     itemOptions,
//                     selectedItem,
//                     (selected) {
//                       setState(() {
//                         selectedItem = selected;
//                       });
//                     },
//                   ),
//                 ),
//               ),

//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: _buildItemOptions(
//                     'Item 2',
//                     itemOptions,
//                     selectedItem,
//                     (selected) {
//                       setState(() {
//                         selectedItem = selected;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: buildToppingSelector(
//                     toppings: toppings,
//                     onToppingTap: (topping) {
//                       setState(() {
//                         topping.isSelected = !topping.isSelected;
//                       });
//                     },
//                   ),
//                 ),
//               ),

//               Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Catatan (Opsional)',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Masukan catatan pesanan kamu',
//                           hintStyle: TextStyle(
//                             color: Colors.grey[400],
//                             fontSize: 12,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 12,
//                           ),
//                         ),
//                         maxLength: 25,
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildItemOptions(
//     String label,
//     List<Map<String, dynamic>> options,
//     String selectedOption,
//     Function(String) onOptionSelected,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         Column(
//           children:
//               options.map((option) {
//                 bool isSelected = selectedOption == option['name'];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6.0),
//                   child: InkWell(
//                     onTap: () => onOptionSelected(option['name']),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F5F5),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Icon(
//                                 isSelected
//                                     ? Icons.radio_button_checked
//                                     : Icons.radio_button_unchecked,
//                                 color:
//                                     isSelected
//                                         ? BaseColors.primary
//                                         : Colors.grey,
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   option['name'],
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ),
//                               if (isSelected)
//                                 IconButton(
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //   context,
//                                     //   MaterialPageRoute(
//                                     //     builder:
//                                     //         (context) => DetailMenuPage(
//                                     //           menu:menu ,
//                                     //           imageUrl: widget.imageUrl,
//                                     //           price: widget.price,
//                                     //         ),
//                                     //   ),
//                                     // );
//                                   },
//                                   icon: Icon(
//                                     Icons.edit,
//                                     size: 20,
//                                     color: Color(0xFF3B1D52),
//                                   ),
//                                 )
//                               else
//                                 Text(
//                                   option['price'] == 0
//                                       ? 'Free'
//                                       : '+${option['price'] ~/ 1000}.000',
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF3B1D52),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           if (isSelected) ...[
//                             const SizedBox(height: 8),
//                             DottedLine(
//                               direction: Axis.horizontal,
//                               dashLength: 8,
//                               dashColor: Colors.grey,
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 const Text(
//                                   'Toast: Original',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   option['price'] == 0
//                                       ? 'Free'
//                                       : '+${option['price'] ~/ 1000}.000',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF3B1D52),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget buildToppingSelector({
//     required List<ToppingOption> toppings,
//     required void Function(ToppingOption) onToppingTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Toppings',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         Column(
//           children:
//               toppings.map((topping) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6),
//                   child: InkWell(
//                     onTap: () => onToppingTap(topping),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F5F5),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 24,
//                             height: 24,
//                             decoration: BoxDecoration(
//                               color:
//                                   topping.isSelected
//                                       ? const Color(0xFF3B1D52)
//                                       : Colors.transparent,
//                               borderRadius: BorderRadius.circular(6),
//                               border: Border.all(
//                                 color:
//                                     topping.isSelected
//                                         ? const Color(0xFF3B1D52)
//                                         : Colors.grey,
//                                 width: 2,
//                               ),
//                             ),
//                             child:
//                                 topping.isSelected
//                                     ? const Icon(
//                                       Icons.check,
//                                       color: Colors.white,
//                                       size: 16,
//                                     )
//                                     : null,
//                           ),
//                           const SizedBox(width: 12),
//                           Image.asset(
//                             topping.imagePath,
//                             width: 24,
//                             height: 24,
//                             fit: BoxFit.contain,
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               topping.name,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '+${topping.price ~/ 1000}.000',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }
// }

// class ToppingOption {
//   final String name;
//   final String imagePath;
//   final int price;
//   bool isSelected;

//   ToppingOption({
//     required this.name,
//     required this.imagePath,
//     required this.price,
//     this.isSelected = false,
//   });
// }

// Widget buildToppingSelector({
//   required List<ToppingOption> toppings,
//   required void Function(ToppingOption) onToppingTap,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         'Toppings',
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(height: 12),
//       Column(
//         children:
//             toppings.map((topping) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6),
//                 child: InkWell(
//                   onTap: () => onToppingTap(topping),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 16,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF5F5F5),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 24,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             color:
//                                 topping.isSelected
//                                     ? const Color(0xFF3B1D52)
//                                     : Colors.transparent,
//                             borderRadius: BorderRadius.circular(6),
//                             border: Border.all(
//                               color:
//                                   topping.isSelected
//                                       ? const Color(0xFF3B1D52)
//                                       : Colors.grey,
//                               width: 2,
//                             ),
//                           ),
//                           child:
//                               topping.isSelected
//                                   ? const Icon(
//                                     Icons.check,
//                                     color: Colors.white,
//                                     size: 16,
//                                   )
//                                   : null,
//                         ),
//                         const SizedBox(width: 12),
//                         Image.asset(
//                           topping.imagePath,
//                           width: 24,
//                           height: 24,
//                           fit: BoxFit.contain,
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             topping.name,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           '+${topping.price ~/ 1000}.000',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     ],
//   );
// }
