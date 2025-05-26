import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  
  // Observable variables
  var cartItems = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var totalCartPrice = 0.0.obs;
  var totalCartItems = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  /// Fetch cart items from API
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      final response = await _cartService.getCartItems();

      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['items'] != null) {
        
        // Convert to List<Map<String, dynamic>> to ensure proper type
        List<dynamic> items = response.data['data']['items'];
        cartItems.value = items.map((item) => Map<String, dynamic>.from(item)).toList();
        
        // Calculate totals after fetching
        _calculateCartTotals();
        
        print('Cart items fetched: ${cartItems.length}');
        print('Cart items data: ${cartItems.value}');
      } else {
        cartItems.clear();
        _resetCartTotals();
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      cartItems.clear();
      _resetCartTotals();
      
      // Only show error snackbar if it's not a network/connectivity issue
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

  /// Add item to cart
  Future<void> addItemToCart(Map<String, dynamic> itemData) async {
    try {
      isLoading.value = true;
      final response = await _cartService.addToCart(itemData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Refresh cart items after successful addition
        await fetchCartItems();
        
        Get.snackbar(
          'Success',
          'Item berhasil ditambahkan ke keranjang',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error adding item to cart: $e');
      throw Exception('Failed to add item to cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove item from cart
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

  /// Update cart item quantity
  Future<void> updateCartItemQuantity(int cartId, int newQuantity) async {
    try {
      isLoading.value = true;
      
      // Find and update the item locally first for immediate UI feedback
      var itemIndex = cartItems.indexWhere((item) => item['id'] == cartId);
      if (itemIndex != -1) {
        cartItems[itemIndex]['quantity'] = newQuantity;
        cartItems.refresh();
        _calculateCartTotals();
      }

      // Then update on server (implement this in your CartService)
      // await _cartService.updateCartItemQuantity(cartId, newQuantity);
      
    } catch (e) {
      print('Error updating cart item quantity: $e');
      // Revert changes on error
      await fetchCartItems();
      Get.snackbar(
        'Error', 
        'Failed to update item quantity',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Calculate cart totals
  void _calculateCartTotals() {
    double total = 0.0;
    int itemCount = 0;

    for (var item in cartItems) {
      int quantity = item['quantity'] ?? 1;
      double price = extractPrice(item);

      total += (price * quantity);
      itemCount += quantity;
    }

    totalCartPrice.value = total;
    totalCartItems.value = itemCount;
    
    print('Cart totals calculated - Price: $total, Items: $itemCount');
  }

  /// Extract price from cart item
  double extractPrice(Map<String, dynamic> item) {
  double price = 0.0;

  try {
    if (item['product'] != null && item['product']['price'] != null) {
      String priceStr = item['product']['price'].toString();
      price = _parsePrice(priceStr);
    } else if (item['price'] != null) {
      String priceStr = item['price'].toString();
      price = _parsePrice(priceStr);
    }
  } catch (e) {
    print('Error extracting price from item: $e');
  }

  return price;
}


  /// Parse price string to double
  double _parsePrice(String priceStr) {
    // Remove currency symbols and formatting
    String cleanPrice = priceStr
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .trim();
    
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  /// Reset cart totals
  void _resetCartTotals() {
    totalCartPrice.value = 0.0;
    totalCartItems.value = 0;
  }

  /// Clear entire cart
  void clearCart() {
    cartItems.clear();
    _resetCartTotals();
  }

  /// Get cart item by product ID
  Map<String, dynamic>? getCartItemByProductId(int productId) {
    try {
      print('Looking for product ID: $productId in cart items: ${cartItems.map((item) => item['product_id']).toList()}');
      
      var foundItem = cartItems.firstWhereOrNull((item) {
        int? itemProductId;
        
        if (item['product_id'] != null) {
          itemProductId = item['product_id'] is int 
              ? item['product_id'] 
              : int.tryParse(item['product_id'].toString());
        } else if (item['productId'] != null) {
          itemProductId = item['productId'] is int 
              ? item['productId'] 
              : int.tryParse(item['productId'].toString());
        } else if (item['product'] != null && item['product']['id'] != null) {
          itemProductId = item['product']['id'] is int 
              ? item['product']['id'] 
              : int.tryParse(item['product']['id'].toString());
        }
        
        print('Comparing: $itemProductId == $productId');
        return itemProductId == productId;
      });
      
      print('Found item: $foundItem');
      return foundItem;
    } catch (e) {
      print('Error getting cart item by product ID: $e');
      return null;
    }
  }

  /// Check if product is in cart
  bool isProductInCart(int productId) {
    bool inCart = getCartItemByProductId(productId) != null;
    print('Product $productId is in cart: $inCart');
    return inCart;
  }

  /// Get product quantity in cart
  int getProductQuantityInCart(int productId) {
    var item = getCartItemByProductId(productId);
    int quantity = item?['quantity'] ?? 0;
    print('Product $productId quantity in cart: $quantity');
    return quantity;
  }

  /// Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;

  /// Get total number of different products in cart
  int get totalUniqueItems => cartItems.length;

  /// Refresh cart data
  Future<void> refreshCart() async {
    await fetchCartItems();
  }
}