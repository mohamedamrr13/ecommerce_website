import 'package:ecommerce_website/core/shared/custom_footer_widget.dart';
import 'package:ecommerce_website/features/home/presentation/widgets/flash_sales_header.dart';
import 'package:ecommerce_website/features/home/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlashSalesHeader(),
                SizedBox(height: 24),
                ProductGrid(),
              ],
            ),
          ),
          CustomFooterWidget()
        ],
      ),
    );
  }
}




