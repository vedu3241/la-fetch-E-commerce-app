import 'package:get/get.dart';
import 'package:lafetch_ecom/app/routes/app_routes.dart';
import 'package:lafetch_ecom/features/nav/bindings/nav_binding.dart';
import 'package:lafetch_ecom/features/nav/view/nav.dart';
import 'package:lafetch_ecom/features/product%20details/binding/product_details_binding.dart';
import 'package:lafetch_ecom/features/product%20details/view/product_details_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.nav, page: () => NavView(), binding: NavBinding()),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
  ];
}
