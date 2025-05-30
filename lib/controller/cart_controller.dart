import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';
import 'package:jiwaapp_task7/model/menu_model.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  var cartItems = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var totalCartPrice = 0.0.obs;
  var totalCartItems = 0.obs;

  get hasFetched => null;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  /// NGAMBIL DATA ITEM CART
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      final response = await _cartService.getCartItems();
      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['items'] != null) {
        List<dynamic> items = response.data['data']['items'];
        cartItems.value =
            items.map((item) => Map<String, dynamic>.from(item)).toList();
        _calculateCartTotals();

        print('Cart items fetched: ${cartItems.length}');
      } else {
        cartItems.clear();
        _resetCartTotals();
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      cartItems.clear();
      _resetCartTotals();
      if (!e.toString().contains('SocketException') &&
          !e.toString().contains('TimeoutException')) {
        Get.snackbar(
          'Error',
          'Failed to load cart items',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart({
    required MenuModel menu,
    required int quantity,
    String? note,
    String? categoryType,
    String? selectedFoodOption,
    String? selectedDrinkOption,
    bool showSnackbar = true,
  }) async {
    try {
      isLoading.value = true;

      Map<String, dynamic> cartData = {
        'product_id': menu.id,
        'quantity': quantity,
        'note': note?.trim() ?? '',
      };

      if (categoryType == 'combo') {
        if (selectedFoodOption != null && selectedFoodOption.isNotEmpty) {
          cartData['food_id'] = selectedFoodOption;
        }
        if (selectedDrinkOption != null && selectedDrinkOption.isNotEmpty) {
          cartData['drink_id'] = selectedDrinkOption;
        }
      }

      final response = await _cartService.addToCart(cartData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCartItems();
        if (showSnackbar) {
          Get.snackbar(
            'Success',
            'Item berhasil ditambahkan ke keranjang',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      print('Error adding item to cart: $e');
      Get.snackbar(
        'Error',
        'Gagal menambahkan item ke keranjang: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeCartItem(int cartId) async {
    try {
      isLoading.value = true;
      await _cartService.deleteCartItem(cartId);
      await fetchCartItems();
      Get.snackbar(
        'Success',
        'Item berhasil dihapus dari keranjang',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error removing cart item: $e');
      Get.snackbar(
        'Error',
        'Failed to remove item from cart',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateCartTotals() {
    double total = 0.0;
    int itemCount = 0;
    for (var item in cartItems) {
      int quantity = item['quantity'] ?? 1;
      double price = extractPrice(item);
      total += price * quantity;
      itemCount += quantity;
    }
    totalCartPrice.value = total;
    totalCartItems.value = itemCount;
    print('Cart totals calculated - Price: $total, Items: $itemCount');
  }

  double extractPrice(Map<String, dynamic> item) {
    double price = 0.0;
    try {
      if (item['product'] != null && item['product']['price'] != null) {
        price = _parsePrice(item['product']['price'].toString());
      } else if (item['price'] != null) {
        price = _parsePrice(item['price'].toString());
      }
    } catch (e) {
      print('Error extracting price from item: $e');
    }
    return price;
  }

  double _parsePrice(String priceStr) {
    String cleanPrice =
        priceStr
            .replaceAll('Rp', '')
            .replaceAll('.', '')
            .replaceAll(',', '')
            .replaceAll(' ', '')
            .trim();
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  void _resetCartTotals() {
    totalCartPrice.value = 0.0;
    totalCartItems.value = 0;
  }

  Map<String, dynamic>? getCartItemByProductId(int productId) {
    try {
      var foundItem = cartItems.firstWhereOrNull((item) {
        int? itemProductId;
        if (item['product_id'] != null) {
          itemProductId =
              item['product_id'] is int
                  ? item['product_id']
                  : int.tryParse(item['product_id'].toString());
        } else if (item['productId'] != null) {
          itemProductId =
              item['productId'] is int
                  ? item['productId']
                  : int.tryParse(item['productId'].toString());
        } else if (item['product'] != null && item['product']['id'] != null) {
          itemProductId =
              item['product']['id'] is int
                  ? item['product']['id']
                  : int.tryParse(item['product']['id'].toString());
        }
        return itemProductId == productId;
      });
      return foundItem;
    } catch (e) {
      print('Error getting cart item by product ID: $e');
      return null;
    }
  }

  /// Cek apakah produk sudah ada dalam cart
  bool isProductInCart(int productId) {
    bool inCart = getCartItemByProductId(productId) != null;
    print('Product $productId is in cart: $inCart');
    return inCart;
  }

  /// Ambil jumlah quantity produk tertentu di cart
  int getProductQuantityInCart(int productId) {
    var item = getCartItemByProductId(productId);
    int quantity = item?['quantity'] ?? 0;
    print('Product $productId quantity in cart: $quantity');
    return quantity;
  }

  /// HELPER FUNCTION UNTUK MENGHITUNG HARGA TOTAL DARI MENU MODEL
  double calculateTotalPrice(MenuModel menu) {
    String cleanPrice = menu.price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }
}
