import 'package:get/get.dart';
import 'package:lafetch_ecom/features/home%20screen/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
