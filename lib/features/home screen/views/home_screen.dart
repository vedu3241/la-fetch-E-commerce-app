import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/features/home%20screen/controllers/home_controller.dart';
import 'package:lafetch_ecom/features/home%20screen/widgets/hero_section.dart';
import 'package:lafetch_ecom/features/home%20screen/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,

        title: Image.asset(
          "assets/logo/lafetch_logo.png",
          width: 100,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Hero Header Section
            const HomeHeroSection(),

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
                                  style: GoogleFonts.plusJakartaSans(
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

                if (controller.selectedCategoryIndex.value >=
                    controller.categories.length) {
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

                    return Obx(() {
                      final isFavorited =
                          controller.isProductFavorited(product.title);
                      return ProductCard(
                        product: product,
                        isFavorited: isFavorited,
                        onFavoritePressed: () {
                          controller.toggleFavorite(product.title);
                        },
                      );
                    });
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
}
