// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/data/repositories/product_repo.dart';
import 'package:lafetch_ecom/main.dart';

class MockProductRepo extends ProductRepo {
  @override
  Future<List<Product>> fetchAllProducts() async {
    return [
      Product(
        id: 1,
        title: "Test Product",
        price: 9.99,
        description: "Test description",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: Rating(rate: 4.5, count: 10),
      ),
    ];
  }

  @override
  Future<List<String>> fetchCategories() async {
    return ["electronics", "jewelery"];
  }
}

void main() {
  setUp(() {
    Get.reset();
  });

  testWidgets('HomeScreen loads and displays products', (WidgetTester tester) async {
    // Inject MockProductRepo before the app starts to avoid real HTTP requests under test environment
    Get.put<ProductRepo>(MockProductRepo());

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify app elements
    expect(find.text('LA FETCH'), findsOneWidget);
    expect(find.text('ALL ITEMS'), findsOneWidget);
    expect(find.text('ELECTRONICS'), findsNWidgets(2));
    expect(find.text('Test Product'), findsOneWidget);
  });
}
