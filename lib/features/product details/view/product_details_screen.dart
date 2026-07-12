import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/features/cart/controller/cart_controller.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';
import 'package:lafetch_ecom/features/product%20details/controller/product_details_controller.dart';

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
          style: GoogleFonts.playfairDisplay(
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
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        }

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
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.error.value,
                    style: GoogleFonts.montserrat(
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
                    child: Text(
                      "Retry",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final product = controller.product.value;
        if (product == null) {
          return Center(
            child: Text(
              "Product not found",
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          );
        }

        // Active image index local state
        final RxInt activeImageIndex = 0.obs;

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
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: const Color(0x66FFFFFF),
                    ),
                  ),
                ),
              ),

              // Main Image Container
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                width: double.infinity,
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(28),
                child: Obx(() {
                  final idx = activeImageIndex.value;
                  if (idx == 1) {
                    // Zoomed/cropped variant
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: OverflowBox(
                        maxHeight: double.infinity,
                        maxWidth: double.infinity,
                        child: SizedBox(
                          width: 480,
                          height: 480,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    );
                  } else if (idx == 2) {
                    // Monochromatic grayscale variant
                    return ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: Image.network(product.image, fit: BoxFit.contain),
                    );
                  } else {
                    // Standard view
                    return Hero(
                      tag: 'product_image_${product.id}',
                      child: Image.network(product.image, fit: BoxFit.contain),
                    );
                  }
                }),
              ),

              // Camera spec/metadata row from mockup
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    _getMockSpecs(product.category),
                    style: GoogleFonts.montserrat(
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

              // Interactive Thumbnails Row
              Obx(() {
                final currentIdx = activeImageIndex.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildThumbnail(
                      index: 0,
                      isSelected: currentIdx == 0,
                      child: Image.network(product.image, fit: BoxFit.contain),
                      onTap: () => activeImageIndex.value = 0,
                    ),
                    const SizedBox(width: 16),
                    _buildThumbnail(
                      index: 1,
                      isSelected: currentIdx == 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: OverflowBox(
                          maxHeight: double.infinity,
                          maxWidth: double.infinity,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => activeImageIndex.value = 1,
                    ),
                    const SizedBox(width: 16),
                    _buildThumbnail(
                      index: 2,
                      isSelected: currentIdx == 2,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () => activeImageIndex.value = 2,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 28),

              // Product Info Block
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Collection category with line next to it
                    Row(
                      children: [
                        Text(
                          "${product.category.toUpperCase()} COLLECTION",
                          style: GoogleFonts.montserrat(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: const Color(0x66FFFFFF),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0x1FFFFFFF),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Product Title
                    Text(
                      product.title.toUpperCase(),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Price tag
                    Text(
                      "\$${product.price.toStringAsFixed(2)} USD",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Elegant Divider
                    Container(height: 1, color: const Color(0x1FFFFFFF)),

                    const SizedBox(height: 20),

                    // Description text
                    Text(
                      product.description,
                      style: GoogleFonts.montserrat(
                        fontSize: 13.5,
                        height: 1.6,
                        color: const Color(0xB3FFFFFF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Add To Cart Button (Full width rectangular)
                    ElevatedButton(
                      onPressed: () {
                        Get.find<CartController>().addToCart(product);
                        Get.snackbar(
                          'ADDED TO CART',
                          '${product.title} has been added to your bag.',
                          backgroundColor: const Color(0xEB1A1A1A),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 8,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 54),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "ADD TO CART",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildThumbnail({
    required int index,
    required bool isSelected,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? const Color(0xff8E66CF)
                : const Color(0x1FFFFFFF),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: child,
      ),
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
