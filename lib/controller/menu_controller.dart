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
  final RxList<Map<String, dynamic>> drinkOptions =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoadingComboOptions = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void toggleDeliveryType(bool isTakeAway) {
    isTakeAwaySelected.value = isTakeAway;
  }

  //METHOD NGAMBIL DATA MENU BERDASARKAN KATEGORI
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

  //NGAMBIL DATA KATEGORI DARI API
  void fetchCategories() async {
    try {
      final fetchedCategories = await _menuService.fetchAllMenus();
      categories.value = fetchedCategories;
    } catch (e) {
      print('Error loading menus: $e');
    }
  }

  //FUNGSI ADD TO CART DI  DETAIL MENU PAGE DAN DI MENU PAGE (MENUITEMCARD)
  void addItemToCart(double price) {
    totalPrice.value += price;
    itemCount.value += 1;
  }

  // UNTUK MENDETEKSI PAGE UNTUK COMBO ATAU NGGAK
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

      final foodCategories =
          categories.value
              .where((category) => category.type == 'food')
              .toList();
      final drinkCategories =
          categories.value
              .where((category) => category.type == 'drink')
              .toList();

      List<Map<String, dynamic>> allFoodOptions = [];
      for (var category in foodCategories) {
        for (var product in category.products) {
          allFoodOptions.add({
            'id': product.id, // Make sure this is the numeric ID
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
            'id': product.id,
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
        selectedFoodOption.value = allFoodOptions.first['id'].toString();
        print(
          'Default food option selected: ${selectedFoodOption.value}',
        ); // Debug log
      }
      if (allDrinkOptions.isNotEmpty) {
        selectedDrinkOption.value = allDrinkOptions.first['id'].toString();
        print(
          'Default drink option selected: ${selectedDrinkOption.value}',
        ); // Debug log
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
    String cleanPrice = menu.price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  void setSelectedFoodOption(String optionId) {
    selectedFoodOption.value = optionId;
    print('Food option selected: $optionId');
  }

  void setSelectedDrinkOption(String optionId) {
    selectedDrinkOption.value = optionId;
    print('Drink option selected: $optionId');
  }

  CategoryModel? get selectedCategory {
    if (categories.value.isEmpty) return null;
    if (selectedCategoryIndex.value >= categories.value.length) return null;
    return categories.value[selectedCategoryIndex.value];
  }

  List<MenuModel> get selectedCategoryProducts =>
      selectedCategory?.products ?? [];
}
