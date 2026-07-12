import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/data/repositories/product_repo.dart';
import 'package:lafetch_ecom/features/cart/controller/cart_controller.dart';
import 'package:lafetch_ecom/features/product%20details/controller/product_details_controller.dart';

class MockProductRepoForDetails extends ProductRepo {
  @override
  Future<Product> fetchSingleProduct(int id) async {
    return Product(
      id: id,
      title: "Detail Product $id",
      price: 19.99,
      description: "Detail description",
      category: "jewelry",
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      rating: Rating(rate: 4.8, count: 5),
    );
  }
}

void main() {
  setUp(() {
    Get.reset();
    Get.testMode = true;
  });

  testWidgets(
    'ProductDetailController fetches single product on initialization',
    (WidgetTester tester) async {
      // 1. Arrange
      final repo = MockProductRepoForDetails();
      Get.put<ProductRepo>(repo);

      // Initialize GetMaterialApp so Get.to navigation doesn't hang
      await tester.pumpWidget(const GetMaterialApp(home: SizedBox()));

      // Set product ID argument by routing to a placeholder
      Get.to(() => const SizedBox(), arguments: 1);
      await tester.pumpAndSettle();

      // 2. Act
      final controller = Get.put(ProductDetailController());

      // Wait for the async load in onInit
      await Future.delayed(Duration.zero);
      await tester.pump();

      // 3. Assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.error.value, isEmpty);
      expect(controller.product.value, isNotNull);
      expect(controller.product.value!.id, 1);
      expect(controller.product.value!.title, "Detail Product 1");
    },
  );

  test('CartController adds, increments, decrements, and clears items', () {
    final controller = CartController();
    final product = Product(
      id: 1,
      title: "Cart Product",
      price: 10.0,
      description: "Desc",
      category: "electronics",
      image: "image_url",
      rating: Rating(rate: 4.0, count: 1),
    );

    // Initial state
    expect(controller.cartItems.isEmpty, true);
    expect(controller.totalPrice, 0.0);
    expect(controller.totalItemsCount, 0);

    // Add product
    controller.addToCart(product);
    expect(controller.cartItems.length, 1);
    expect(controller.cartItems.first.quantity, 1);
    expect(controller.totalPrice, 10.0);
    expect(controller.totalItemsCount, 1);

    // Increment
    controller.incrementQuantity(1);
    expect(controller.cartItems.first.quantity, 2);
    expect(controller.totalPrice, 20.0);

    // Decrement
    controller.decrementQuantity(1);
    expect(controller.cartItems.first.quantity, 1);
    expect(controller.totalPrice, 10.0);

    // Decrement again (removes from cart)
    controller.decrementQuantity(1);
    expect(controller.cartItems.isEmpty, true);
    expect(controller.totalPrice, 0.0);
  });
}
