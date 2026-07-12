import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/app/routes/app_routes.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/features/home%20screen/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _selectedCategoryIndex = 0;
  final Set<String> _favoritedProducts = {};

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 24),
          onPressed: () {},
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
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Hero Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 24.0,
                  bottom: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COLLECTION 2024",
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "CHOSEN\nPIECES",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                        height: 1.05,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Divider(color: const Color(0x14FFFFFF), thickness: 1),
                  ],
                ),
              ),
            ),

            // Horizontal Categories Scroll Tab Bar
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isCategoriesLoading.value) {
                  return const SizedBox(
                    height: 48,
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  );
                }

                if (controller.categories.isEmpty) {
                  return const SizedBox(height: 48);
                }

                return Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected =
                            index == controller.selectedCategoryIndex.value;
                        return GestureDetector(
                          onTap: () {
                            controller.selectedCategoryIndex.value = index;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 28.0),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.categories[index],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11.5,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xff8E66CF)
                                        : const Color(0x66FFFFFF),
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 1.5,
                                  width: isSelected ? 30 : 0,
                                  color: const Color(0xff8E66CF),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                );
              }),
            ),

            // Vertical Space
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Product Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: Obx(() {
                if (controller.isProductListLoading.value) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  );
                }

                if (controller.categories.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No categories available",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                  );
                }

                if (controller.selectedCategoryIndex.value >= controller.categories.length) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }

                final filteredProducts = controller.filteredProducts;

                if (filteredProducts.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 28,
                    childAspectRatio: 0.55,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = filteredProducts[index];
                    final isFavorited = _favoritedProducts.contains(
                      product.title,
                    );

                    return _buildProductCard(product, isFavorited);
                  }, childCount: filteredProducts.length),
                );
              }),
            ),

            // Bottom Spacing for Floating Glass Nav Bar
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, bool isFavorited) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: product.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image container with clean aesthetic background
          Expanded(
            child: Stack(
              children: [
                // Styled Container containing the network image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors
                        .white, // Standard premium fashion styling for web/app product images
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: Colors.black26,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          _getCategoryIcon(product.category),
                          size: 38,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),

                // Favorite Heart Icon Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isFavorited) {
                          _favoritedProducts.remove(product.title);
                        } else {
                          _favoritedProducts.add(product.title);
                        }
                      });
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: const Color(0x66000000),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0x14FFFFFF),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.redAccent : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Product Details Text
          Text(
            product.category.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: const Color(0x66FFFFFF),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "\$${product.price.toStringAsFixed(2)}",
            style: GoogleFonts.montserrat(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xD9FFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toUpperCase()) {
      case "JEWELRY":
      case "JEWELERY":
        return Icons.auto_awesome_outlined;
      case "ELECTRONICS":
        return Icons.headphones_outlined;
      case "CLOTHING":
      case "MEN'S CLOTHING":
      case "WOMEN'S CLOTHING":
        return Icons.checkroom_outlined;
      case "ACCESSORIES":
        return Icons.work_outline_rounded;
      default:
        return Icons.shopping_bag_outlined;
    }
  }
}
