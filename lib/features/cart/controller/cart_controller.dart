import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lafetch_ecom/data/models/cart_model.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  double get totalPrice {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  int get totalItemsCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _loadFromStorage() {
    try {
      final box = Hive.box('cart_box');
      final List<dynamic>? savedItems = box.get('cart_items');
      if (savedItems != null) {
        final items = savedItems.map((item) {
          return CartItem.fromJson(Map<String, dynamic>.from(item));
        }).toList();
        cartItems.assignAll(items);
      }
    } catch (e) {
      debugPrint("Error loading cart: $e");
    }
  }

  void _saveToStorage() {
    try {
      final box = Hive.box('cart_box');
      final data = cartItems.map((item) => item.toJson()).toList();
      box.put('cart_items', data);
    } catch (e) {
      debugPrint("Error saving cart: $e");
    }
  }

  void addToCart(Product product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex != -1) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
    cartItems.refresh();
    _saveToStorage();
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    cartItems.refresh();
    _saveToStorage();
  }

  void incrementQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
      _saveToStorage();
    }
  }

  void decrementQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
      _saveToStorage();
    }
  }

  void clearCart() {
    cartItems.clear();
    cartItems.refresh();
    _saveToStorage();
  }
}
