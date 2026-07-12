import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';
import 'package:lafetch_ecom/features/product%20details/controller/product_details_controller.dart';
import 'package:lafetch_ecom/features/product%20details/widgets/add_to_cart_button.dart';
import 'package:lafetch_ecom/features/product%20details/widgets/network_product_image.dart';
import 'package:lafetch_ecom/features/product%20details/widgets/product_info_section.dart';

class ProductDetailsScreen extends GetView<ProductDetailController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "LA FETCH",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Get.find<NavController>().changeIndex(1);
              Get.back();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.product.value == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        }

        // On error this block will get executed
        if (controller.error.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Failed to load product details",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.error.value,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => controller.retryLoading(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    //retry button
                    child: Text(
                      "Retry",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        //if product not found
        final product = controller.product.value;
        if (product == null) {
          return Center(
            child: Text(
              "Product not found",
              style: GoogleFonts.plusJakartaSans(color: Colors.white),
            ),
          );
        }

        //if product is found show the details
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product details header label
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text(
                    "PRODUCT DETAILS",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: const Color(0x66FFFFFF),
                    ),
                  ),
                ),
              ),

              // Main Image Container
              ProductImageSection(controller: controller, product: product),

              // Camera spec/metadata row from mockup
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    _getMockSpecs(product.category),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0x4DFFFFFF),
                      letterSpacing: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Product Info Block
              ProductInfoSection(product: product),
              const SizedBox(height: 32),
              // Add To Cart Button (Full width rectangular)
              AddToCartButton(product: product),

              const SizedBox(height: 48),
            ],
          ),
        );
      }),
    );
  }

  String _getMockSpecs(String category) {
    switch (category.toUpperCase()) {
      case "JEWELRY":
      case "JEWELERY":
        return "18K SOLID GOLD   •   OBSIDIAN MONOLITH   •   PARIS ATELIER";
      case "ELECTRONICS":
        return "ANC 3.0 SYSTEM   •   40H BATTERY   •   HI-RES WIRELESS";
      case "CLOTHING":
      case "MEN'S CLOTHING":
      case "WOMEN'S CLOTHING":
        return "100% ORGANIC COTTON   •   PREMIUM SILHOUETTE   •   MADE IN ITALY";
      default:
        return "LIMITED EDITION   •   HAND-CRAFTED DETAILED   •   EXCLUSIVELY STYLED";
    }
  }
}

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
    required this.controller,
    required this.product,
  });

  final ProductDetailController controller;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.infinity,
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(28),
      child: controller.activeImageIndex.value == 1
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: SizedBox(
                  width: 480,
                  height: 480,
                  child: NetworkProductImage(
                    imageUrl: product!.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            )
          : controller.activeImageIndex.value == 2
          ? NetworkProductImage(
              imageUrl: product!.image,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
            )
          : Hero(
              tag: 'product_image_${product!.id}',
              child: NetworkProductImage(
                imageUrl: product!.image,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}
