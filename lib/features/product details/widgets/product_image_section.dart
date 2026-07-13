import 'package:flutter/material.dart';
import 'package:lafetch_ecom/data/models/product_model.dart';
import 'package:lafetch_ecom/features/product%20details/controller/product_details_controller.dart';
import 'package:lafetch_ecom/features/product%20details/widgets/network_product_image.dart';

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
