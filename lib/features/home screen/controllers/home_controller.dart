import 'package:get/get.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/data/repositories/product_repo.dart';

class HomeController extends GetxController {
  final ProductRepo productRepo = Get.find<ProductRepo>();
  final allProducts = <Product>[].obs;
  final categories = <String>[].obs;
  final selectedCategoryIndex = 0.obs;

  final isProductListLoading = false.obs;
  final isCategoriesLoading = false.obs;

  List<Product> get filteredProducts {
    final selectedIdx = selectedCategoryIndex.value;
    if (selectedIdx >= categories.length) return [];

    final selectedCategory = categories[selectedIdx];
    if (selectedCategory == "ALL ITEMS") {
      return allProducts;
    }

    return allProducts
        .where((p) => p.category.toUpperCase() == selectedCategory)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      isProductListLoading.value = true;
      final result = await productRepo.fetchAllProducts();
      allProducts.assignAll(result);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isProductListLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      final result = await productRepo.fetchCategories();
      final formattedCategories = [
        "ALL ITEMS",
        ...result.map((c) => c.toUpperCase())
      ];
      categories.assignAll(formattedCategories);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isCategoriesLoading.value = false;
    }
  }
}
