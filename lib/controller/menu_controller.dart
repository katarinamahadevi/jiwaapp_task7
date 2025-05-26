import 'package:get/get.dart';
import 'package:jiwaapp_task7/model/category_model.dart';
import 'package:jiwaapp_task7/model/menu_model.dart';
import 'package:jiwaapp_task7/services/menu_service.dart';

class MenuItemController extends GetxController {
  var isTakeAwaySelected = true.obs;
  var selectedCategoryIndex = 0.obs;
  var totalPrice = 0.0.obs;
  var itemCount = 0.obs;
  final Rx<List<CategoryModel>> categories = Rx<List<CategoryModel>>([]);
  final MenuService _menuService = MenuService();
  final RxInt quantity = 1.obs;
  final RxString selectedFoodOption = ''.obs;
  final RxString selectedDrinkOption = ''.obs;
  final RxList<Map<String, dynamic>> foodOptions = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> drinkOptions = <Map<String, dynamic>>[].obs;
  final RxBool isLoadingComboOptions = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void toggleDeliveryType(bool isTakeAway) {
    isTakeAwaySelected.value = isTakeAway;
  }

  void selectCategory(int index) async {
    selectedCategoryIndex.value = index;
    final categoryId = categories.value[index].id;
    try {
      final updatedCategory = await _menuService.fetchMenuByCategory(
        categoryId,
      );
      categories.value[index] = updatedCategory;
      categories.refresh();
    } catch (e) {
      print('Failed to fetch menu by category: $e');
    }
  }

  void fetchCategories() async {
    try {
      final fetchedCategories = await _menuService.fetchAllMenus();
      categories.value = fetchedCategories;
    } catch (e) {
      print('Error loading menus: $e');
    }
  }
  void addItemToCart(double price) {
    totalPrice.value += price;
    itemCount.value += 1;
  }
  void removeItemFromCart(double price) {
    if (totalPrice.value >= price) {
      totalPrice.value -= price;
    }
    if (itemCount.value > 0) {
      itemCount.value -= 1;
    }
  }
  void resetCartState() {
    totalPrice.value = 0.0;
    itemCount.value = 0;
  }
  void updateCartState(double newTotalPrice, int newItemCount) {
    totalPrice.value = newTotalPrice;
    itemCount.value = newItemCount;
  }

  // UNTUK MENDETEKSI DIA COMBO ATAU NGGAK
  void initializeDetailPage(String? categoryType) {
    quantity.value = 1;
    selectedFoodOption.value = '';
    selectedDrinkOption.value = '';
    foodOptions.clear();
    drinkOptions.clear();
    
    if (categoryType == 'combo') {
      loadComboOptions();
    }
  }

  void loadComboOptions() async {
    isLoadingComboOptions.value = true;
    try {
      if (categories.value.isEmpty) {
         fetchCategories();
      }

      final foodCategories = categories.value
          .where((category) => category.type == 'food')
          .toList();
      final drinkCategories = categories.value
          .where((category) => category.type == 'drink')
          .toList();

      List<Map<String, dynamic>> allFoodOptions = [];
      for (var category in foodCategories) {
        for (var product in category.products) {
          allFoodOptions.add({
            'name': product.name,
            'price': product.price,
            'category': category.name,
            'type': category.type,
          });
        }
      }

      List<Map<String, dynamic>> allDrinkOptions = [];
      for (var category in drinkCategories) {
        for (var product in category.products) {
          allDrinkOptions.add({
            'name': product.name,
            'price': product.price,
            'category': category.name,
            'type': category.type,
          });
        }
      }

      foodOptions.value = allFoodOptions;
      drinkOptions.value = allDrinkOptions;

      if (allFoodOptions.isNotEmpty) {
        selectedFoodOption.value = foodOptions.first['name'] ?? '';
      }
      if (allDrinkOptions.isNotEmpty) {
        selectedDrinkOption.value = drinkOptions.first['name'] ?? '';
      }
    } catch (e) {
      print('Error loading combo options: $e');
      foodOptions.clear();
      drinkOptions.clear();
    } finally {
      isLoadingComboOptions.value = false;
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  double calculateTotalPrice(MenuModel menu) {
    // Extract numeric value from price string (remove 'Rp', '.', etc.)
    String cleanPrice = menu.price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  void setSelectedFoodOption(String option) {
    selectedFoodOption.value = option;
  }

  void setSelectedDrinkOption(String option) {
    selectedDrinkOption.value = option;
  }

  CategoryModel? get selectedCategory {
    if (categories.value.isEmpty) return null;
    if (selectedCategoryIndex.value >= categories.value.length) return null;
    return categories.value[selectedCategoryIndex.value];
  }

  List<MenuModel> get selectedCategoryProducts =>
      selectedCategory?.products ?? [];
}