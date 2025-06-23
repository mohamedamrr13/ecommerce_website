import 'package:ecommerce_website/features/home/presentation/widgets/product_item.dart';
import 'package:ecommerce_website/utils/appconstraints.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppConstraints.screenWidth(context) <= 900 ? 2 : 4,
          crossAxisSpacing: 32,
          mainAxisSpacing: 0),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const ProductCard();
      },
    );
  }
}
