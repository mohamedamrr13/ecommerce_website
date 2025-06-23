import 'package:ecommerce_website/utils/appconstraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onHover: (value) {
            if (value == true) {
              setState(() {
                isHovered = true;
              });
            } else {
              setState(() {
                isHovered = false;
              });
            }
          },
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: const Center(
                          child:
                              Icon(Icons.image, size: 48, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '-40%',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      isHovered
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                height:
                                    AppConstraints.isMobile(context) ? 20 : 40,
                                child: Center(
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8.sp),
                                  ),
                                ),
                              ))
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Item X',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$80.00',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
