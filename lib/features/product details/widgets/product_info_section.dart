import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/app/theme/colors.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Collection category
          Row(
            children: [
              Text(
                "${product!.category.toUpperCase()} COLLECTION",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: const Color(0x66FFFFFF),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(height: 1, color: const Color(0x1FFFFFFF)),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Product Title
          Text(
            product!.title,
            style: GoogleFonts.plusJakartaSans(
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
            "\₹ ${product!.price.toStringAsFixed(2)}",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 20),

          // Elegant Divider
          Container(height: 1, color: const Color(0x1FFFFFFF)),

          const SizedBox(height: 20),

          // Description text
          Text(
            product!.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              height: 1.6,
              color: const Color(0xB3FFFFFF),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
