import 'package:ecommerce_website/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.6,
        crossAxisSpacing: 50,
        mainAxisSpacing: 32,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const ProductCard();
      },
    );
  }
}
