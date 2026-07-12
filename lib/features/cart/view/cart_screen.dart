import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/features/cart/controller/cart_controller.dart';
import 'package:lafetch_ecom/features/cart/widgets/cart_empty_state.dart';
import 'package:lafetch_ecom/features/cart/widgets/cart_list_section.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final navController = Get.find<NavController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: Text(
          "YOUR BAG",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return CartEmptyState(navController: navController);
        }
        return CartListSection();
      }),
    );
  }
}
