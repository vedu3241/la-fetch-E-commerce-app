import 'package:get/get.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/data/repositories/product_repo.dart';

class ProductDetailController extends GetxController {
  final ProductRepo productRepo = Get.find<ProductRepo>();

  final Rxn<Product> product = Rxn<Product>();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  
  int? productId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is int) {
      productId = args;
      loadProduct(args);
    } else {
      error.value = 'Invalid product ID';
    }
  }

  Future<void> loadProduct(int id) async {
    try {
      isLoading.value = true;
      error.value = '';
      final fetchedProduct = await productRepo.fetchSingleProduct(id);
      product.value = fetchedProduct;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void retryLoading() {
    if (productId != null) {
      loadProduct(productId!);
    }
  }
}
