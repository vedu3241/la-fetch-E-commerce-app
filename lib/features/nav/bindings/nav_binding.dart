import 'package:get/get.dart';
import 'package:lafetch_ecom/data/repositories/product_repo.dart';
import 'package:lafetch_ecom/features/cart/controller/cart_controller.dart';
import 'package:lafetch_ecom/features/home%20screen/controllers/home_controller.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';

class NavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductRepo());
    Get.put(NavController());
    Get.put(HomeController());
    Get.put(CartController());
  }
}
