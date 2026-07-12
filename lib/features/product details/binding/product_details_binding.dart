import 'package:get/get.dart';
import 'package:lafetch_ecom/features/product%20details/controller/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}
