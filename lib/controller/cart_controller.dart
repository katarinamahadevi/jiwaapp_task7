import 'package:get/get.dart';
import 'package:jiwaapp_task7/services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  var cartItems = [].obs;
  var isLoading = false.obs;

  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      final response = await _cartService.getCartItems();
      cartItems.value = response.data['data']; 
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart items');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addItemToCart(Map<String, dynamic> itemData) async {
    try {
      isLoading.value = true;
      await _cartService.addToCart(itemData);
      await fetchCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeCartItem(int cartId) async {
    try {
      isLoading.value = true;
      await _cartService.deleteCartItem(cartId);
      await fetchCartItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item from cart');
    } finally {
      isLoading.value = false;
    }
  }
}
