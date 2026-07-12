import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/app/routes/app_routes.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorited;
  final VoidCallback onFavoritePressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorited,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: product);
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
                    color: Colors.white, // Standard premium fashion styling for web/app product images
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Hero(
                    tag: 'product_image_${product.id}',
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
                ),

                // Favorite Heart Icon Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: onFavoritePressed,
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
            style: GoogleFonts.plusJakartaSans(
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
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "₹ ${product.price.toStringAsFixed(2)}",
            style: GoogleFonts.plusJakartaSans(
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
