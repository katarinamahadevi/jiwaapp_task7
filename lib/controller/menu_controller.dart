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

  CategoryModel? get selectedCategory {
    if (categories.value.isEmpty) return null;
    if (selectedCategoryIndex.value >= categories.value.length) return null;
    return categories.value[selectedCategoryIndex.value];
  }
  

  List<MenuModel> get selectedCategoryProducts =>
      selectedCategory?.products ?? [];
      
}
