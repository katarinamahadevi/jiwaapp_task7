import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiwaapp_task7/controller/cart_controller.dart';
import 'package:jiwaapp_task7/theme/color.dart';
import 'package:jiwaapp_task7/model/menu_model.dart';

Widget buildOrderListSection() {
  final CartController controller = Get.put(CartController());
  controller.fetchCartItems();

  return Obx(() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.cartItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: Text("Keranjang kosong")),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Pesanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.offNamed('/menu'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambah Menu',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...controller.cartItems.map((item) {
            final product = item['product'];
            final quantity = item['quantity'];
            final cartId = item['id'];
            final price = controller.extractPrice(item);
            final originalPrice = price + 14000;

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product['image_url_text'] ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rp${price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Rp${originalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // IconButton(
                        //   icon: Image.asset(
                        //     'assets/image/image_update.png',
                        //     width: 20,
                        //     height: 20,
                        //   ),
                        //   onPressed: () {
                        //   },
                        // ),
                        IconButton(
                          icon: Image.asset(
                            'assets/image/image_delete.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            if (cartId != null) {
                              controller.removeCartItem(cartId);
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (quantity > 1) {
                                  await controller.addToCart(
                                    menu: MenuModel.fromJson(product),
                                    quantity: quantity - 1,
                                  );
                                }
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Text(
                                quantity.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await controller.addToCart(
                                  menu: MenuModel.fromJson(product),
                                  quantity: quantity + 1,
                                );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 32),
              ],
            );
          }).toList(),
        ],
      ),
    );
  });
}
